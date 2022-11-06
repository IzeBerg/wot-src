package net.wg.data.constants
{
   public class RolesState
   {
      
      public static const ALL:String = "None";
      
      public static const COMANDER:String = "commander";
      
      public static const GUNNER:String = "gunner";
      
      public static const LOADER:String = "loader";
      
      public static const DRIVER:String = "driver";
      
      public static const RADIOMAN:String = "radioman";
      
      public static const TANKMEN:Vector.<String> = new <String>[RolesState.COMANDER,RolesState.DRIVER,RolesState.RADIOMAN,RolesState.GUNNER,RolesState.LOADER];
       
      
      public function RolesState()
      {
         super();
      }
   }
}
