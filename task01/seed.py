from faker import Faker
import psycopg2, logging, random

fake = Faker()

conn = psycopg2.connect(host="localhost", port="5432", database="hw03", user="postgres", password="mysecretpassword")
c = conn.cursor()

# Заповнюємо статуси - status
statuses_id_list = []
for s in ["new", "in progress", "completed"]:
    c.execute("INSERT INTO status (name) VALUES (%s) RETURNING id", (s,))
    statuses_id_list.append(c.fetchone()[0])

# Заповнюємо користувачів з тасками - таблиці usrs, tasks
for _ in range(2000): # Кількість користувачів
    c.execute("INSERT INTO users (fullname, email) VALUES (%s, %s) RETURNING id", (fake.unique.name(),fake.unique.email()))
    user_id = c.fetchone()[0]
    
    # Кількість тасків від 0 до 3 для кожного користувача
    for _ in range(random.randint(0,3)):
        c.execute("INSERT INTO tasks (title, description, status_id, user_id) VALUES (%s, %s, %s, %s)",
                   (fake.word(), fake.word(), random.choice(statuses_id_list), user_id))

try:
    conn.commit()
except psycopg2.DatabaseError as err:
    logging.error(f"Database Error: {err}")
    conn.rollback()
finally:
    c.close()
    conn.close()