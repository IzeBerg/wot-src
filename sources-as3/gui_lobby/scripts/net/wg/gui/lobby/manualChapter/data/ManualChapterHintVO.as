package net.wg.gui.lobby.manualChapter.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ManualChapterHintVO extends DAAPIDataClass
   {
       
      
      public var text:String = "";
      
      public var icon:String = "";
      
      public function ManualChapterHintVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
