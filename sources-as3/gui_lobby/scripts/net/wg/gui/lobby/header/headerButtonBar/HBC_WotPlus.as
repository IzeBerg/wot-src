package net.wg.gui.lobby.header.headerButtonBar
{
   import flash.text.TextField;
   import net.wg.infrastructure.interfaces.IImage;
   import net.wg.utils.ICommons;
   import net.wg.utils.IStageSizeDependComponent;
   import net.wg.utils.StageSizeBoundaries;
   
   public class HBC_WotPlus extends HeaderButtonContentItem implements IStageSizeDependComponent
   {
      
      private static const PADDING_RIGHT:int = 10;
       
      
      public var wotPlusIcon:IImage = null;
      
      public var label:TextField = null;
      
      public var state:TextField = null;
      
      private var _isCompact:Boolean = false;
      
      private var _commons:ICommons;
      
      public function HBC_WotPlus()
      {
         this._commons = App.utils.commons;
         super();
         minScreenPadding.left = 0;
         minScreenPadding.right = 0;
         additionalScreenPadding.left = 0;
         additionalScreenPadding.right = 0;
         App.stageSizeMgr.register(this);
      }
      
      override public function getSeparatorType() : String
      {
         return HeaderButtonContentItem.SEPARATOR_DOT;
      }
      
      override protected function onDispose() : void
      {
         App.stageSizeMgr.unregister(this);
         this.wotPlusIcon.dispose();
         this.wotPlusIcon = null;
         this.label = null;
         this.state = null;
         super.onDispose();
      }
      
      override protected function updateSize() : void
      {
         this.label.visible = this.state.visible = !this._isCompact;
         if(this._isCompact)
         {
            bounds.width = this.label.x >> 0;
            minScreenPadding.right = 0;
         }
         else
         {
            bounds.width = Math.max(this.label.x + this.label.width,this.state.x + this.state.width) >> 0;
            minScreenPadding.right = PADDING_RIGHT;
         }
         super.updateSize();
      }
      
      override protected function updateData() : void
      {
         if(data)
         {
            this.wotPlusIcon.source = data.wotPlusIcon;
            this.label.htmlText = data.label;
            this.state.htmlText = data.state;
            this._commons.updateTextFieldSize(this.label,true,true);
            this._commons.updateTextFieldSize(this.state,true,true);
         }
         super.updateData();
      }
      
      public function setStateSizeBoundaries(param1:int, param2:int) : void
      {
         var _loc3_:Boolean = param1 < StageSizeBoundaries.WIDTH_1920;
         if(this._isCompact != _loc3_)
         {
            this._isCompact = _loc3_;
            invalidateSize();
         }
      }
      
      override public function set data(param1:Object) : void
      {
         super.data = param1;
      }
   }
}
