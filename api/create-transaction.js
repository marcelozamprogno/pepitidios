export default async function handler(req, res) {
  if (req.method !== 'POST') {
    return res.status(405).json({ error: 'Method Not Allowed' });
  }

  const token = process.env.INVICTUSPAY_TOKEN;
  if (!token) {
    return res.status(500).json({ error: 'INVICTUSPAY_TOKEN não configurado no backend.' });
  }

  const body = req.body;

  try {
    const response = await fetch('https://api.invictuspay.app.br/v1/transactions', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${token}`,
        'Accept': 'application/json'
      },
      body: JSON.stringify(body)
    });

    const data = await response.json();

    if (!response.ok) {
      console.error('InvictusPay API Error:', data);
      return res.status(response.status).json({ error: 'Erro ao processar transação na InvictusPay', details: data });
    }

    return res.status(200).json(data);
  } catch (error) {
    console.error('Fetch Error:', error);
    return res.status(500).json({ error: 'Erro interno no servidor' });
  }
}
