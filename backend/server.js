const express = require('express');
const cors = require('cors');

const app = express();
const PORT = 3000;

app.use(cors());
app.use(express.json());

const cards = [
  {
    id: 'card_001',
    network: 'VISA',
    maskedNumber: '•••• 4521',
    expiry: '08/29',
    status: 'active',
  },
  {
    id: 'card_002',
    network: 'MASTERCARD',
    maskedNumber: '•••• 7814',
    expiry: '03/28',
    status: 'frozen',
  },
];

const users = [
  {
    username: 'himanshu',
    password: 'password123',
    userId: 'user_001',
  },
];

const sessions = new Map();

app.post('/auth/login', (req, res) => {
  const { username, password } = req.body;

  const user = users.find(
    (item) =>
      item.username === username && item.password === password,
  );

  if (!user) {
    return res.status(401).json({
      error: {
        code: 'INVALID_CREDENTIALS',
        message: 'Invalid username or password',
      },
    });
  }

  const accessToken = `mock-token-${user.userId}`;

  sessions.set(accessToken, {
    userId: user.userId,
    expiresAt: new Date(
      Date.now() + 60 * 60 * 1000,
    ).toISOString(),
  });

  return res.json({
    accessToken,
    session: {
      userId: user.userId,
      expiresAt: sessions.get(accessToken).expiresAt,
    },
  });
});

app.get('/auth/session', (req, res) => {
  const authorization = req.headers.authorization;

  if (!authorization?.startsWith('Bearer ')) {
    return res.status(401).json({
      error: {
        code: 'UNAUTHORIZED',
        message: 'Authentication required',
      },
    });
  }

  const token = authorization.substring('Bearer '.length);
  const session = sessions.get(token);

  if (!session) {
    return res.status(401).json({
      error: {
        code: 'UNAUTHORIZED',
        message: 'Invalid session',
      },
    });
  }

  return res.json(session);
});

app.post('/auth/logout', (req, res) => {
  const authorization = req.headers.authorization;

  if (authorization?.startsWith('Bearer ')) {
    const token = authorization.substring('Bearer '.length);
    sessions.delete(token);
  }

  return res.status(204).send();
});

app.get('/health', (req, res) => {
  res.json({
    status: 'ok',
  });
});

app.get('/cards', (req, res) => {
  res.json(cards);
});

app.listen(PORT, () => {
  console.log(`CardVault API running on http://localhost:${PORT}`);
});