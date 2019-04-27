import { IUserCharacter } from './user-character';

// TODO: figure out how to use JSDoc or some other type of documentation formatting

export interface IUser {
  id: string;
  name: string;
  email: string;
  avatar: string;
  xp: number;
  totalXp: number;
  rank: number;
  active: boolean;

  /** coming soon */
  // character: IUserCharacter;
}
