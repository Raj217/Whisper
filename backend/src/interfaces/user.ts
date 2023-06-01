export default interface User {
    id?: string;
    firstName: string;
    lastName?: string;
    profileImageUrl?:string;
    email:string;              
    password?: string;
    pexelsIDVisited?: string[]  
    unsplashIDVisited?: string[];
    isOuthAuth: boolean;
}