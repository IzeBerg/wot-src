package net.wg.gui.lobby.eventProgression.components.metaLevel.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class MetaLevelVO extends DAAPIDataClass
   {
       
      
      public var seasonLevel:String = "";
      
      public var playerLevel:String = "";
      
      public var bgImageId:int = -1;
      
      public function MetaLevelVO(param1:Object)
      {
         super(param1);
      }
   }
}
