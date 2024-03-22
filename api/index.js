const express = require('express');
const jwt = require('jsonwebtoken');
const cors = require('cors');

const app = express();
app.use(express.json());
app.use(cors());

const secret = 'This is a secret';
const mockUsers = [
  {
    id: 1,
    username: 'admin',
    password: '123456',
    fullName: 'Administrator',
    attendances: [],
  },
  {
    id: 2,
    username: 'user1',
    password: '111111',
    fullName: 'User One',
    attendances: [
      {
        date: "2024-01-07",
        status: true,
        canCheckIn: false,
      },
      {
        date: "2024-01-21",
        status: false,
        canCheckIn: false,
      },
      {
        date: "2024-02-18",
        status: true,
        canCheckIn: false,
      },
      {
        date: "2024-03-17",
        status: null,
        canCheckIn: true,
      },
      {
        date: "2024-03-28",
        status: null,
        canCheckIn: false,
      },
    ],
  },
  {
    id: 3,
    username: 'user2',
    password: '222222',
    fullName: 'User Two',
    attendances: [
      {
        date: "2024-01-07",
        status: true,
        canCheckIn: false,
      },
      {
        date: "2024-01-21",
        status: true,
        canCheckIn: false,
      },
      {
        date: "2024-02-18",
        status: true,
        canCheckIn: false,
      },
      {
        date: "2024-03-17",
        status: null,
        canCheckIn: true,
      },
      {
        date: "2024-03-28",
        status: null,
        canCheckIn: false,
      },
    ],
  },
  {
    id: 4,
    username: 'user3',
    password: '333333',
    fullName: 'User Three',
    attendances: [
      {
        date: "2024-01-07",
        status: false,
        canCheckIn: false,
      },
      {
        date: "2024-01-21",
        status: true,
        canCheckIn: false,
      },
      {
        date: "2024-02-18",
        status: true,
        canCheckIn: false,
      },
      {
        date: "2024-03-17",
        status: null,
        canCheckIn: true,
      },
      {
        date: "2024-03-28",
        status: null,
        canCheckIn: false,
      },
    ],
  }
];

// root path
app.get('/', function (req, res) {
  res.send('Hello World from Node.js + Express');
});

// path, endpoint, route
app.post('/login', function (req, res) {
  const { username, password } = req.body;
  if (!username || !password) {
    res.status(400).send("Username and password are required");
    return;
  }

  const user = mockUsers.find(
    (user) => user.username === username && user.password === password
  );
  if (user) { // type coerce
    var token = jwt.sign(
      {
        id: user.id,
      },
      secret
    );
    res.status(200).send({
      token,
      user: {
        fullName: user.fullName,
      },
    });
  } else {
    res.status(401).send("Unauthorized");
  }
});

function verifyToken(req, res) {
  const token = req.headers.authorization?.split(" ")[1];
  if (!token) {
    res.status(401).send("Unauthorized");
    return null;
  }

  try {
    const decoded = jwt.verify(token, secret);
    const user = mockUsers.find((user) => user.id === decoded.id);
    if (!user) {
      res.status(404).send("Not found");
      return null;
    }
    return user;
  } catch (e) {
    res.status(401).send(e.message);
    return null;
  }
}

app.get('/attendances', function (req, res) {
  const user = verifyToken(req, res);
  if (!user) {
    return;
  }
  res.status(200).send({ attendances: user.attendances });
});

const PORT = 3001;
app.listen(PORT, () => console.log(`Listening on port ${PORT}`));