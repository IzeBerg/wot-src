package net.wg.gui.lobby.comp7.battleResults.components
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.lobby.battleResults.data.Comp7SubTaskVO;
   import net.wg.gui.lobby.interfaces.ISubtaskComponent;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class Comp7QualificationSubTask extends UIComponentEx implements ISubtaskComponent
   {
      
      private static const ICON_SCALE:Number = 0.5;
       
      
      public var title:TextField;
      
      public var descr:TextField;
      
      public var icon:Image;
      
      public var lineMC:MovieClip;
      
      private var _data:Comp7SubTaskVO = null;
      
      public function Comp7QualificationSubTask()
      {
         super();
         this.icon.scaleX = this.icon.scaleY = ICON_SCALE;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data && isInvalid(InvalidationType.DATA))
         {
            this.title.htmlText = this._data.title;
            this.descr.htmlText = this._data.descr;
            this.icon.source = this._data.icon;
         }
      }
      
      override protected function onDispose() : void
      {
         this.icon.dispose();
         this.icon = null;
         this.descr = null;
         this.title = null;
         this.lineMC = null;
         this._data = null;
         super.onDispose();
      }
      
      public function setData(param1:Object) : void
      {
         this._data = Comp7SubTaskVO(param1);
         invalidateData();
      }
      
      public function disableLinkBtns(param1:Vector.<String>) : void
      {
      }
      
      override public function get height() : Number
      {
         return this.lineMC.y;
      }
   }
}
