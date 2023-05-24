### rename the `weight` column to `atomic_mass`

> ALTER TABLE properties RENAME weight TO atomic_mass;

### rename the `melting_point` column to `melting_point_celsius` and the `boiling_point` column to `boiling_point_celsius`

> ALTER TABLE properties RENAME melting_point TO melting_point_celsius;
> 
> ALTER TABLE properties RENAME boiling_point TO boiling_point_celsius;

### `melting_point_celsius` and `boiling_point_celsius` columns should not accept `null values`

> ALTER TABLE properties ALTER COLUMN boiling_point_celsius SET NOT NULL;
>
> ALTER TABLE properties ALTER COLUMN melting_point_celsius SET NOT NULL;

### add the UNIQUE constraint to the `symbol` and name columns from the `elements` table

> ALTER TABLE elements ADD CONSTRAINT symbol UNIQUE(symbol), ADD CONSTRAINT name UNIQUE(name);

### `symbol` and `name` columns should have the `NOT NULL` constraint
> ALTER TABLE elements ALTER COLUMN symbol SET NOT NULL, ALTER COLUMN name SET 
NOT NULL;

### set the atomic_number column from the properties table as a foreign key that references the column of the same name in the elements table
> ALTER TABLE ONLY properties ADD CONSTRAINT properties_elements_fk FOREIGN KEY (atomic_number) REFERENCES elements(atomic_number);

### create a types table that will store the three types of elements
> CREATE TABLE types (type_id integer PRIMARY KEY NOT NULL, type character varying(30) NOT NULL);

### add three rows to your types table whose values are the three different types from the properties table
> INSERT INTO types VALUES (1, 'metal');
> 
> INSERT INTO types VALUES (2, 'nonmetal');
> 
> INSERT INTO types VALUES (3, 'metalloid');

### properties table should have a type_id foreign key column that references the type_id column from the types table. It should be an INT with the NOT NULL constraint
> ALTER TABLE properties add column type_id int not null default 1;
> 
> ALTER TABLE ONLY properties ADD CONSTRAINT properties_type_id_fkey FOREIGN KEY (type_id) REFERENCES types(type_id);

### capitalize the first letter of all the symbol values in the elements table. Be careful to only capitalize the letter and not change any others
> UPDATE elements SET symbol=INITCAP(LOWER(symbol));

### remove all the trailing zeros after the decimals from each row of the `atomic_mass` column
> ALTER TABLE properties ALTER COLUMN atomic_mass TYPE DECIMAL;
> 
> UPDATE properties SET atomic_mass = atomic_mass::REAL;
>
### insert Flourine and Neon
> INSERT INTO elements VALUES (9, 'F', 'Fluorine');
>
> INSERT INTO public.elements VALUES (10, 'Ne', 'Neon');
> 
> INSERT INTO properties VALUES(9, 'nonmetal', 18.998, -220, -188.1, 2);
> 
> INSERT INTO properties VALUES(10, 'nonmetal', 20.18, -248.6, -246.1, 2);