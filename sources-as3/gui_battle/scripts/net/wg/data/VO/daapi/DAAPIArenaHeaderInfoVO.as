package net.wg.data.VO.daapi
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class DAAPIArenaHeaderInfoVO extends DAAPIDataClass
   {
       
      
      public var mapName:String = "";
      
      public var battleTypeFrameLabel:String = "";
      
      public var battleTypeLocaleStr:String = "";
      
      public var winText:String = "";
      
      public var winTextShort:String = "";
      
      public function DAAPIArenaHeaderInfoVO(param1:Object)
      {
         super(param1);
      }
   }
}
