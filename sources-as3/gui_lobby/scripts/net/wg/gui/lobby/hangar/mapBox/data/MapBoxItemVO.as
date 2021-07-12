package net.wg.gui.lobby.hangar.mapBox.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class MapBoxItemVO extends DAAPIDataClass
   {
       
      
      public var icon:String = "";
      
      public var count:String = "";
      
      public var isCompleted:Boolean = false;
      
      public function MapBoxItemVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
