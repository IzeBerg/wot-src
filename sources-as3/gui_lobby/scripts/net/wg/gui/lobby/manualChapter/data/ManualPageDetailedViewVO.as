package net.wg.gui.lobby.manualChapter.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ManualPageDetailedViewVO extends DAAPIDataClass
   {
       
      
      public var chapterTitle:String = "";
      
      public var title:String = "";
      
      public var description:String = "";
      
      public var background:String = "";
      
      public var video:String = "";
      
      public var isNew:Boolean = false;
      
      public var contentRendererLinkage:String = "";
      
      public var contentRendererData:Object = null;
      
      public var id:String = "";
      
      public var pageType:String = "";
      
      public function ManualPageDetailedViewVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDispose() : void
      {
         App.utils.data.cleanupDynamicObject(this.contentRendererData);
         this.contentRendererData = null;
         super.onDispose();
      }
   }
}
