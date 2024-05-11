package net.wg.gui.lobby.techtree.constants
{
   public class NodeEntityType
   {
      
      public static const UNDEFINED:uint = 0;
      
      public static const NATION_TREE:uint = 1;
      
      public static const RESEARCH_ROOT:uint = 2;
      
      public static const RESEARCH_ITEM:uint = 3;
      
      public static const TOP_VEHICLE:uint = 4;
      
      public static const NEXT_VEHICLE:uint = 5;
      
      public static const BLUEPRINT_TREE:uint = 6;
       
      
      public function NodeEntityType()
      {
         super();
      }
      
      public static function isVehicleType(param1:uint) : Boolean
      {
         return param1 == NATION_TREE || param1 == RESEARCH_ROOT || param1 == TOP_VEHICLE || param1 == NEXT_VEHICLE || param1 == BLUEPRINT_TREE;
      }
   }
}
