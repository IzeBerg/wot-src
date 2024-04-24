package net.wg.gui.lobby.manualChapter.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ManualChapterVideoVO extends DAAPIDataClass
   {
       
      
      public var previewImage:String = "";
      
      public var videoUrl:String = "";
      
      public function ManualChapterVideoVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
