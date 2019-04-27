import { EventSource } from './../enums/event-source';

export interface IExternalEvent {
  source: EventSource /** e.g. GITHUB */;
  type: string /** e.g. ISSUE */;
  action?: string /** e.g. CLOSED */;
  data?: any;
  timestamp: string;
}
