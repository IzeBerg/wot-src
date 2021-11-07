package net.wg.gui.fortBase
{
   import net.wg.infrastructure.interfaces.IDAAPIDataClass;
   
   public interface IBuildingBaseVO extends IDAAPIDataClass
   {
       
      
      function get defResVal() : int;
      
      function set defResVal(param1:int) : void;
      
      function get hpVal() : int;
      
      function set hpVal(param1:int) : void;
      
      function get buildingLevel() : int;
      
      function set buildingLevel(param1:int) : void;
      
      function get uid() : String;
      
      function set uid(param1:String) : void;
      
      function get iconSource() : String;
      
      function set iconSource(param1:String) : void;
      
      function get maxHpValue() : uint;
      
      function set maxHpValue(param1:uint) : void;
      
      function get maxDefResValue() : uint;
      
      function set maxDefResValue(param1:uint) : void;
      
      function get animationType() : int;
      
      function set animationType(param1:int) : void;
   }
}
