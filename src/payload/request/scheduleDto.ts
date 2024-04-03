import {
  Bus,
  GenderEnum,
  MainLocation,
  RoleEnum,
  SubLocation,
} from "@prisma/client";
export interface ScheduleDto {
  departureId: string;
  date: Date;
  enable: boolean;
  numberOfblock: number | null;
  availableSeat: number | undefined;
  busId: string;
}

interface guestInforResponeDto {
  id: string;
  name: string;
  gender: GenderEnum;
  scheduleId: string;
  user_type: RoleEnum;
  createdAt: Date;
  updatedAt: Date;
}

export interface ScheduleResponseDto {
  id: string;
  date: string | Date;
  numberOfblock: number;
  availableSeat: number | null;
  departureId: string;
  enable: boolean;
  departure: {
    id: string;
    departureTime: string;
    from: {
      id: string;
      mainLocationName: string;
      createdAt: string;
      updatedAt: string;
    };
    destination: {
      id: string;
      mainLocationName: string;
      createdAt: string;
      updatedAt: string;
    };
  };
  pickupLocation: {
    id: string;
    subLocationName: string;
    mainLocationId: string;
    enable: boolean;
    createdAt: string;
    updatedAt: string;
  };
  dropLocation: {
    id: string;
    subLocationName: string;
    mainLocationId: string;
    enable: boolean;
    createdAt: string;
    updatedAt: string;
  };
  guestInfor: guestInforResponeDto[] | null;
  booking: any[] | null;
  Waitting: any[] | null;
  Cancel: any[] | null;
  bus: any[] | null;
}

export interface BlockSeatUserDto {
  name: string;
  gender: GenderEnum;
}
