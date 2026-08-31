CREATE TABLE ingredients (
    ingredient_id SERIAL PRIMARY KEY,
    ingredient_name VARCHAR(255) NOT NULL,
    protein FLOAT DEFAULT 0,
    carbs FLOAT DEFAULT 0,
    fat FLOAT DEFAULT 0,
    fiber FLOAT DEFAULT 0
);

CREATE TABLE foods (
    food_id SERIAL PRIMARY KEY,
    food_name VARCHAR(255) NOT NULL
);

CREATE TABLE food_ingredients (
    food_id INTEGER REFERENCES foods(food_id) ON DELETE CASCADE,
    ingredient_id INTEGER REFERENCES ingredients(ingredient_id) ON DELETE CASCADE,
    ingredient_amount FLOAT NOT NULL,
    PRIMARY KEY (food_id, ingredient_id)
);

CREATE TABLE food_logs (
    log_id SERIAL PRIMARY KEY,
    date_and_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    food_id INTEGER REFERENCES foods(food_id) ON DELETE SET NULL,
    ingredient_id INTEGER REFERENCES ingredients(ingredient_id) ON DELETE SET NULL,
    amount FLOAT NOT NULL,
    CONSTRAINT check_single_item_type CHECK (
        (food_id IS NOT NULL AND ingredient_id IS NULL) OR 
        (food_id IS NULL AND ingredient_id IS NOT NULL)
    )
);
