package net.wg.gui.lobby.battleMatters.components
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.gui.lobby.battleMatters.data.LinkedSetAwardVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.IImage;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   
   public class LinkedSetAward extends UIComponentEx
   {
       
      
      public var icon:IImage = null;
      
      public var value:TextField = null;
      
      public var check:Sprite = null;
      
      private var _data:LinkedSetAwardVO;
      
      private var _toolTipMgr:ITooltipMgr;
      
      public function LinkedSetAward()
      {
         super();
         this._toolTipMgr = App.toolTipMgr;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
         addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data != null && isInvalid(InvalidationType.DATA))
         {
            this.icon.source = this._data.icon;
            this.value.htmlText = this._data.value;
            this.check.visible = this._data.isCompleted;
            alpha = this._data.alpha;
         }
      }
      
      override protected function onDispose() : void
      {
         this.icon.dispose();
         this.icon = null;
         this.value = null;
         this.check = null;
         this._data = null;
         this._toolTipMgr = null;
         removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
         removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
         super.onDispose();
      }
      
      public function setData(param1:LinkedSetAwardVO) : void
      {
         this._data = param1;
         invalidateData();
      }
      
      private function onMouseOverHandler(param1:MouseEvent) : void
      {
         if(StringUtils.isNotEmpty(this._data.tooltip))
         {
            this._toolTipMgr.showComplex(this._data.tooltip);
         }
         else
         {
            this._toolTipMgr.showSpecial.apply(this._toolTipMgr,[this._data.specialAlias,null].concat(this._data.specialArgs));
         }
      }
      
      private function onMouseOutHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.hide();
      }
   }
}
