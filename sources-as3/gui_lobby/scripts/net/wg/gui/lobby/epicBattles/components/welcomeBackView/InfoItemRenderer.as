package net.wg.gui.lobby.epicBattles.components.welcomeBackView
{
   import fl.motion.easing.Linear;
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.lobby.epicBattles.data.InfoItemRendererVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.data.ListData;
   import scaleform.clik.interfaces.IListItemRenderer;
   import scaleform.clik.motion.Tween;
   
   public class InfoItemRenderer extends UIComponentEx implements IListItemRenderer
   {
      
      private static const FADE_IN_DURATION:Number = 500;
       
      
      public var titleTF:TextField;
      
      public var descriptionTF:TextField;
      
      public var icon:UILoaderAlt;
      
      public var glow:Sprite;
      
      private var _rendererData:InfoItemRendererVO = null;
      
      private var _index:uint = 0;
      
      private var _selected:Boolean = false;
      
      private var _owner:UIComponent = null;
      
      private var _fadeTween:Tween = null;
      
      public function InfoItemRenderer()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.titleTF = null;
         this.descriptionTF = null;
         this.icon.dispose();
         this.icon = null;
         this.glow = null;
         this._rendererData.dispose();
         this._rendererData = null;
         this._owner = null;
         if(this._fadeTween)
         {
            this._fadeTween.dispose();
            this._fadeTween = null;
         }
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         alpha = 0;
         this.glow.mouseEnabled = this.glow.mouseChildren = false;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._rendererData && isInvalid(InvalidationType.DATA))
         {
            this.titleTF.htmlText = this._rendererData.titleLabel;
            this.descriptionTF.htmlText = this._rendererData.descriptionLabel;
            this.icon.source = this._rendererData.iconSource;
            this._fadeTween = new Tween(FADE_IN_DURATION,this,{"alpha":1},{
               "paused":false,
               "ease":Linear.easeOut,
               "delay":this._rendererData.showDelay
            });
         }
      }
      
      public function getData() : Object
      {
         return this._rendererData;
      }
      
      public function setData(param1:Object) : void
      {
         this._rendererData = InfoItemRendererVO(param1);
         invalidateData();
      }
      
      public function setListData(param1:ListData) : void
      {
         this.index = param1.index;
         this.selected = param1.selected;
      }
      
      public function get index() : uint
      {
         return this._index;
      }
      
      public function set index(param1:uint) : void
      {
         this._index = param1;
      }
      
      public function get selectable() : Boolean
      {
         return false;
      }
      
      public function set selectable(param1:Boolean) : void
      {
      }
      
      public function get owner() : UIComponent
      {
         return this._owner;
      }
      
      public function set owner(param1:UIComponent) : void
      {
         this._owner = param1;
      }
      
      public function get selected() : Boolean
      {
         return this._selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         this._selected = param1;
      }
   }
}
