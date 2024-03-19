create database dogshop;
drop database dogshop;

use dogshop;

CREATE TABLE suppliers (
  id INT IDENTITY(1,1) PRIMARY KEY,
  name NVARCHAR(255),
  address NVARCHAR(255), 
  email NVARCHAR(255),
  phone NVARCHAR(20)
);

CREATE TABLE users (
  id INT IDENTITY(1,1) PRIMARY KEY,
  fullname NVARCHAR(250) NOT NULL,
  email NVARCHAR(250) NOT NULL UNIQUE,
  password NVARCHAR(250) NOT NULL,
  roleid INT NOT NULL,
  phone NVARCHAR(20),
  image nvarchar(255)
);

CREATE TABLE products (
  id INT IDENTITY(1,1) PRIMARY KEY,
  name NVARCHAR(450) NOT NULL,
  description NVARCHAR(450) NOT NULL, 
  category NVARCHAR(450) NOT NULL,
  price FLOAT NOT NULL,
  discount INT NOT NULL, 
  image NVARCHAR(450) NOT NULL,
  stock INT NOT NULL
);

CREATE TABLE suppliers_products (
  sid INT NOT NULL,
  pid INT NOT NULL,
  FOREIGN KEY (sid) REFERENCES suppliers(id),
  FOREIGN KEY (pid) REFERENCES products(id)
);

create table comments (
	uid int not null,
	pid int not null,
	comment nvarchar(255) not null,
	dateComment datetime not null,
	CONSTRAINT fk_product_comment FOREIGN KEY (pid) REFERENCES products(id),
	CONSTRAINT fk_user_comment FOREIGN KEY (uid) REFERENCES users(id),
)

CREATE TABLE orders (
  oid INT IDENTITY(1,1) PRIMARY KEY,
  totalprice FLOAT NOT NULL,
  address nvarchar(255),
  note nvarchar(255),
  date VARCHAR(450) NOT NULL,
  uid INT NOT NULL,
  CONSTRAINT fk_user FOREIGN KEY (uid) REFERENCES users(id)
);

CREATE TABLE orders_details (
  oid INT NOT NULL,
  pid INT NOT NULL,
  price FLOAT NOT NULL, 
  quantity INT NOT NULL,
  CONSTRAINT fk_order FOREIGN KEY (oid) REFERENCES orders(oid),
  CONSTRAINT fk_product FOREIGN KEY (pid) REFERENCES products(id)  
);


CREATE TABLE Blog (
  id INT PRIMARY KEY,
  title VARCHAR(100),
  image NVARCHAR(450) NOT NULL,
  content TEXT,
  lastUpdated DATETIME
);

INSERT INTO suppliers (name, address, email, phone)
VALUES
  ('Pawsome Pet Supplies', '123 Main St, New York, NY 10001', 'sales@abcflowers.com', '212-123-4567'),
  ('Woof World', '456 Park Ave, Miami, FL 33001', 'contact@zengardens.com', '305-234-3456'),
  ('Canine Corner', '789 Oak Rd, Chicago, IL 60001','orders@cityplants.com', '312-555-1234');

INSERT INTO products (name, description, category, price, discount, image, stock)
VALUES
('Golden Retriever', 'Golden Retrievers are friendly, intelligent, and devoted dogs, known for their golden coats and gentle temperament.', 'Large Breed Dogs', 999.99, 0, 'golden-retriever.jpg', 20),
('German Shepherd', 'German Shepherds are loyal, courageous, and highly trainable dogs, prized for their versatility and intelligence.', 'Large Breed Dogs', 899.99, 0, 'german-shepherd.jpg', 15),
('Labrador Retriever', 'Labrador Retrievers are outgoing, even-tempered, and versatile dogs, beloved as family companions and working dogs.', 'Large Breed Dogs', 799.99, 0, 'labrador.jpg', 25),
('Bulldog', 'Bulldogs are sturdy, muscular, and affectionate dogs, characterized by their wrinkled face and pushed-in nose.', 'Medium Breed Dogs', 699.99, 0, 'bulldog.jpg', 10), 
('Beagle', 'Beagles are curious, friendly, and merry dogs, known for their keen sense of smell and howling bark.', 'Medium Breed Dogs', 599.99, 0, 'beagle.jpg', 30),
('Poodle', 'Poodles are active, intelligent, and elegant dogs, available in various sizes and coat colors.', 'Medium Breed Dogs', 799.99, 0, 'poodle.jpeg', 20),
('Dachshund', 'Dachshunds are playful, courageous, and affectionate dogs, characterized by their long body and short legs.', 'Small Breed Dogs', 499.99, 0, 'dachshund.jpg', 15),
('Shih Tzu', 'Shih Tzus are charming, affectionate, and outgoing dogs, known for their long, flowing coat and friendly disposition.', 'Small Breed Dogs', 599.99, 0, 'shihtzu.jpg', 20),  
('Chihuahua', 'Chihuahuas are tiny, bold, and loyal dogs, often with a big attitude in a small package.', 'Small Breed Dogs', 399.99, 0, 'chihuahua.jpg', 10),
('Siberian Husky', 'Siberian Huskies are outgoing, mischievous, and athletic dogs, recognized for their striking appearance and wolf-like features.', 'Husky Breeds', 1099.99, 0, 'siberianhusky3.jpg', 15),
('Alaskan Malamute', 'Alaskan Malamutes are strong, independent, and loyal dogs, bred for their strength and endurance in cold climates.', 'Husky Breeds', 1199.99, 0, 'alaskan-malamute.jpg', 10),
('Akita', 'Akitas are dignified, loyal, and courageous dogs, originating from Japan and revered for their loyalty and protective nature.', 'Husky Breeds', 1299.99, 0, 'akita.jpg', 10),
('Affenpinscher', 'The Affenpinscher is a small breed of dog known for its terrier-like personality and monkey-like face. They are playful, curious, and affectionate companions.', 'Small Breed Dogs', 799.99, 0, 'affenpinscher.jpg', 10),
('African', 'The African Dog, also known as the Africanis, is a landrace of dog native to Africa. They are intelligent, agile, and adaptable dogs bred for hunting, herding, and guarding.', 'Medium Breed Dogs', 899.99, 0, 'african.jpg', 8),
('Basenji', 'The Basenji is a small, elegant breed of dog known for its unique yodel-like bark and cat-like grooming habits. They are independent, curious, and energetic dogs with a strong prey drive.', 'Medium Breed Dogs', 999.99, 0, 'basenji.jpg', 6),
('Boxer', 'The Boxer is a medium to large breed of dog known for its muscular build, square head, and distinctive underbite. They are intelligent, loyal, and playful companions, often used as family pets and working dogs.', 'Large Breed Dogs', 1499.99, 0, 'boxer.jpg', 12),
('Cockapoo', 'The Cockapoo is a crossbreed dog resulting from the breeding of a Cocker Spaniel and a Poodle. They are affectionate, outgoing, and intelligent dogs, known for their hypoallergenic coat and friendly disposition.', 'Medium Breed Dogs', 1299.99, 0, 'cockapoo.jpg', 10),
('Dhole', 'The Dhole, also known as the Asiatic Wild Dog or Indian Wild Dog, is a species of canid native to South and Southeast Asia. They are highly social, cooperative hunters known for their distinctive whistling calls.', 'Wild Dogs', 1999.99, 0, 'dhole.jpg', 4),
('Keeshond', 'The Keeshond is a medium-sized breed of dog known for its distinctive "spectacles" markings around the eyes and luxurious double coat. They are intelligent, affectionate, and outgoing companions.', 'Medium Breed Dogs', 1399.99, 0, 'keeshond.jpg', 8),
('Kelpie', 'The Australian Kelpie is a medium-sized breed of dog known for its agility, intelligence, and herding instinct. They are energetic, loyal, and hardworking dogs bred for working on farms and ranches.', 'Herding Dogs', 1599.99, 0, 'kelpie.jpg', 6),
('Lhasa', 'The Lhasa Apso is a small breed of dog originating from Tibet. They are known for their long, flowing coat and lion-like appearance. Lhasa Apsos are loyal, spirited, and independent dogs with a keen sense of hearing.', 'Small Breed Dogs', 1199.99, 0, 'lhasa.jpg', 10),
('Pitbull', 'The American Pit Bull Terrier, often referred to simply as the Pitbull, is a medium-sized breed of dog known for its strength, athleticism, and loyalty. They are intelligent, energetic, and affectionate companions.', 'Medium Breed Dogs', 1699.99, 0, 'pitbull.jpg', 8),
('Saluki', 'The Saluki, also known as the Persian Greyhound, is a breed of dog known for its grace, elegance, and speed. They are sighthounds bred for hunting and coursing game in the deserts of the Middle East.', 'Hound Dogs', 1799.99, 0, 'saluki.jpg', 6),
('Shiba', 'The Shiba Inu is a small to medium-sized breed of dog native to Japan. They are independent, spirited, and bold dogs known for their fox-like appearance and fiery personality.', 'Small Breed Dogs', 1499.99, 0, 'shiba.jpg', 10),
('Tervuren', 'The Belgian Tervuren is a medium to large breed of dog belonging to the herding group. They are intelligent, versatile, and agile dogs with a strong work ethic and protective instinct.', 'Herding Dogs', 1699.99, 0, 'tervuren.jpg', 8),
('Vizsla', 'The Vizsla is a medium-sized breed of dog known for its athleticism, hunting prowess, and gentle demeanor. They are versatile, energetic, and affectionate companions bred for hunting and retrieving game birds.', 'Medium Breed Dogs', 1599.99, 0, 'vizsla.jpg', 10);

INSERT INTO suppliers_products (sid, pid)
VALUES
  (1, 1),
  (2, 1),
  (3, 1),
  (1, 2),
  (2, 2),
  (2, 3),
  (3, 3),
  (1, 4),
  (3, 4),
  (1, 5),
  (2, 5),
  (3, 5),
  (1, 6),
  (2, 6),
  (2, 7),
  (3, 7),
  (1, 8),
  (3, 8),
  (1, 9),
  (2, 9),
  (3, 9),
  (1, 10),
  (2, 10),
  (2, 11),
  (3, 11),
  (1, 12),
  (3, 12),
  (1, 13),
  (2, 13),
  (2, 14),
  (3, 14),
  (1, 15),
  (3, 15),
  (1, 16),
  (2, 16),
  (3, 16),
  (1, 17),
  (2, 17),
  (2, 18),
  (3, 18),
  (1, 19),
  (3, 19),
  (1, 20),
  (2, 20),
  (2, 21),
  (3, 21),
  (1, 22),
  (2, 22),
  (3, 22);


INSERT INTO users (fullname, email, password, roleid, phone,image)
VALUES
('Tuan Anh', 'tuananh0405@gmail.com', '12345678', 0, '0123456789', NULL);

INSERT INTO users (fullname, email, password, roleid, phone,image)
VALUES
('User1', 'user1@gmail.com', '123', 0, '0123456789', NULL),
('Admin1', 'admin1@gmail.com', '123', 1, '0123456789', NULL);

INSERT INTO comments (uid, pid, comment, dateComment) VALUES
(1, 1, 'This is a comment from user 1 on post 1', '2024-03-05'),
(2, 2, 'This is a comment from user 2 on post 2', '2024-03-05'),
(2, 3, 'This is another comment from user 2 on post 3', '2024-03-05');

INSERT INTO comments (uid, pid, comment, dateComment) VALUES
(1, 1, 'This is a comment from user 1 on post 2', '2024-03-05'),
(1, 1, 'This is a comment from user 1 on post 3', '2024-03-04'),
(1, 1, 'This is a comment from user 1 on post 4', '2024-03-03');

INSERT INTO Blog (id, title, image, content, lastUpdated)
VALUES
(1, 'The Importance of Socializing Your Dog', 'socializing.jpg', 'Socializing your dog is crucial for their mental and emotional well-being, as well as their behavior in different situations. Proper socialization helps dogs become well-adjusted and confident pets, reducing the risk of fear, aggression, and anxiety. In this post, we will discuss the importance of socializing your dog and provide tips for successful socialization experiences.', '2024-03-11'),
(2, 'Understanding Dog Body Language', 'body-language.jpg', 'Understanding dog body language is essential for effective communication and interaction with your canine companion. Dogs use a variety of signals and cues to express their emotions, intentions, and needs, and being able to interpret these cues can help prevent misunderstandings and conflicts. In this post, we will explore common dog body language signals and what they mean.', '2024-03-10'),
(3, 'How to Prevent Separation Anxiety in Dogs', 'separation-anxiety.jpg', 'Separation anxiety is a common behavioral issue in dogs, characterized by excessive distress or agitation when left alone. It can lead to destructive behaviors, excessive barking, and other problems if left untreated. In this post, we will discuss how to prevent separation anxiety in dogs and help them feel more comfortable and secure when alone.', '2024-03-09'),
(4, 'Choosing the Right Dog Food', 'dog-food.jpg', 'Choosing the right dog food is essential for your pets health, vitality, and longevity. With so many options available on the market, it can be challenging to know which food is best for your dogs specific needs and preferences. In this post, we will provide tips for selecting high-quality dog food and understanding nutritional labels.', '2024-03-08'),
(5, 'The Benefits of Regular Exercise for Dogs', 'exercise.jpg', 'Regular exercise is essential for maintaining your dogs physical health, mental well-being, and overall quality of life. From daily walks to interactive play sessions, there are many ways to keep your dog active and engaged. In this post, we will explore the benefits of regular exercise for dogs and provide ideas for fun and stimulating activities.', '2024-03-07'),
(6, 'Common Health Issues in Dogs', 'health-issues.jpg', 'Like humans, dogs are susceptible to a variety of health issues, ranging from minor ailments to more serious conditions. Recognizing the signs and symptoms of common health problems in dogs is essential for early detection and treatment. In this post, we will discuss some of the most common health issues in dogs and how to prevent or manage them.', '2024-03-06'),
(7, 'Grooming Tips for Dogs', 'grooming.jpg', 'Regular grooming is an important aspect of caring for your dogs physical health and appearance. From bathing and brushing to nail trimming and ear cleaning, there are many grooming tasks that should be performed regularly to keep your dog looking and feeling their best. In this post, we will share grooming tips and techniques for dogs of all breeds and coat types.', '2024-03-05'),
(8, 'The Benefits of Training Your Dog', 'training-benefits.jpg', 'Training your dog is about more than just teaching them obedience commands—it is also about building a strong bond and fostering mutual respect and trust. In addition to improving your dogs behavior, training provides mental stimulation and helps prevent problem behaviors. In this post, we will explore the benefits of training your dog and offer advice for successful training sessions.', '2024-03-04'),
(9, 'Traveling with Your Dog: Tips and Essentials', 'travel.jpg', 'Traveling with your dog can be a fun and rewarding experience, but it also requires careful planning and preparation. Whether you are taking a road trip, flying, or staying in a hotel, there are several things to consider to ensure your dogs safety, comfort, and enjoyment. In this post, we will provide tips and essential items for traveling with your dog.', '2024-03-03'),
(10, 'How to Choose the Right Dog Breed for You', 'breed.jpg', 'Choosing the right dog breed is an important decision that should be based on your lifestyle, preferences, and expectations. From size and energy level to grooming needs and temperament, there are many factors to consider when selecting a dog breed that will be a good fit for you and your family. In this post, we will discuss how to choose the right dog breed and provide information about different breeds and their characteristics.', '2024-03-02'),
(11, 'Creating a Safe and Dog-Friendly Home Environment', 'home.jpg', 'Creating a safe and dog-friendly home environment is essential for your pets health, happiness, and well-being. From securing hazardous items to providing comfortable resting areas, there are many steps you can take to make your home safe and welcoming for your canine companion. In this post, we will share tips and ideas for creating a dog-friendly home environment.', '2024-03-01'),
(12, 'The Importance of Dental Care for Dogs', 'dental-care.jpg', 'Dental care is an often overlooked aspect of canine health, but it is essential for preventing dental problems and maintaining your dogs overall well-being. Poor dental hygiene can lead to gum disease, tooth decay, and other serious health issues. In this post, we will discuss the importance of dental care for dogs and provide tips for keeping your dogs teeth and gums healthy.', '2024-02-29'),
(13, 'Fostering a Senior Dog: Benefits and Considerations', 'senior-dog.jpg', 'Fostering a senior dog can be a rewarding and fulfilling experience, providing love and companionship to an older dog in need of a loving home. While senior dogs may require additional care and attention, they also offer many benefits, including calm temperament and gratitude. In this post, we will explore the benefits and considerations of fostering a senior dog and provide tips for successful senior dog care.', '2024-02-28'),
(14, 'The Role of Dogs in Therapy and Emotional Support', 'therapy.jpg', 'Dogs have long been recognized for their therapeutic and emotional support capabilities, offering comfort, companionship, and unconditional love to people in need. Whether as therapy animals or emotional support animals, dogs play a vital role in improving the mental and emotional well-being of their human counterparts. In this post, we will explore the role of dogs in therapy and emotional support and discuss how they can positively impact the lives of people with various needs and challenges.', '2024-02-27'),
(15, 'Recognizing and Preventing Heatstroke in Dogs', 'heatstroke.jpg', 'Heatstroke is a serious and potentially life-threatening condition that can affect dogs, especially during the hot summer months. Recognizing the signs of heatstroke and taking steps to prevent it are essential for keeping your dog safe and healthy in hot weather. In this post, we will discuss how to recognize and prevent heatstroke in dogs and provide tips for keeping your pet cool and comfortable during the summer.', '2024-02-26'),
(16, 'Caring for a Pregnant Dog: Tips and Advice', 'pregnant.jpg', 'Caring for a pregnant dog requires special attention and care to ensure the health and well-being of both the mother and her puppies. From nutrition and exercise to prenatal veterinary care and whelping preparations, there are many things to consider when caring for a pregnant dog. In this post, we will provide tips and advice for caring for a pregnant dog throughout all stages of her pregnancy and beyond.', '2024-02-25');