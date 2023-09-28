package net.wg.gui.battle.battleloading.vo
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ShortInfoVO extends DAAPIDataClass
   {
       
      
      public var battleTypeLocaleStr:String = "";
      
      public var battleTypeFrameLabel:String = "";
      
      public var winText:String = "";
      
      public var mapName:String = "";
      
      public function ShortInfoVO(param1:Object)
      {
         super(param1);
      }
   }
}
