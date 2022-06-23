package net.wg.gui.lobby.demonstration.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class MapPointVO extends DAAPIDataClass
   {
       
      
      public var posX:int = 0;
      
      public var posY:int = 0;
      
      public var pointType:String = "";
      
      public var color:String = "";
      
      public var id:int = 0;
      
      public function MapPointVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
