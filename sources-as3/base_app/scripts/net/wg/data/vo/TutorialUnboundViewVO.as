package net.wg.data.vo
{
   import flash.display.DisplayObject;
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class TutorialUnboundViewVO extends DAAPIDataClass
   {
       
      
      public var viewTutorialId:String = "";
      
      public var componentPaths:Vector.<String>;
      
      private var _viewContent:DisplayObject = null;
      
      public function TutorialUnboundViewVO(param1:Object = null)
      {
         this.componentPaths = new Vector.<String>(0);
         super(param1);
      }
      
      override protected function onDispose() : void
      {
         this._viewContent = null;
         this.componentPaths.splice(0,this.componentPaths.length);
         this.componentPaths = null;
         super.onDispose();
      }
      
      public function addView(param1:String, param2:DisplayObject) : void
      {
         this.viewTutorialId = param1;
         this._viewContent = param2;
      }
      
      public function get viewContent() : DisplayObject
      {
         return this._viewContent;
      }
   }
}
