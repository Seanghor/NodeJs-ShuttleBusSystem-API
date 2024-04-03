export interface SubLocationDto {
  subLocationName: string;
  mainLocationId: string;
}

export interface UpdateSubLocationDto {
  subLocationName: string;
  mainLocationId: string;
  enable: boolean;
}
