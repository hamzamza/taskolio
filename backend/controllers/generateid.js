import { v4 as uuidv4 } from 'uuid';

export default function  generateShortUUID() {
  const uuid = uuidv4();
  const shortUUID = uuid.slice(0, 8); // Adjust the length as per your requirement
  return shortUUID;
}