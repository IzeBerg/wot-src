package net.wg.gui.lobby.manual.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ChapterItemRendererVO extends DAAPIDataClass
   {
       
      
      public var label:String = "";
      
      public var image:String = "";
      
      public var tooltip:String = "";
      
      public var index:int = -1;
      
      public var counter:String = "";
      
      public function ChapterItemRendererVO(param1:Object)
      {
         super(param1);
      }
   }
}
