package net.wg.gui.lobby.clans.profile.renderers
{
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.gui.components.controls.InfoIcon;
   import net.wg.gui.components.controls.TableRenderer;
   import net.wg.gui.lobby.clans.profile.VOs.ClanProfileProvinceVO;
   import net.wg.infrastructure.interfaces.IInfoIcon;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.utils.ICommons;
   import scaleform.clik.constants.InvalidationType;
   
   public class ClanProfileProvinceItemRenderer extends TableRenderer
   {
      
      private static const PROVINCE_NORMAL_WIDTH:int = 180;
      
      private static const PROVINCE_ROBBED_WIDTH:int = 160;
      
      private static const ROBBED_ICON_GAP:int = 5;
       
      
      public var front:TextField = null;
      
      public var province:TextField = null;
      
      public var map:TextField = null;
      
      public var primeTime:TextField = null;
      
      public var days:TextField = null;
      
      public var robbedIcon:IInfoIcon = null;
      
      private var _rendererVO:ClanProfileProvinceVO = null;
      
      private var _toolTipMgr:ITooltipMgr = null;
      
      private var _commons:ICommons = null;
      
      public function ClanProfileProvinceItemRenderer()
      {
         super();
      }
      
      override public function setData(param1:Object) : void
      {
         super.setData(param1);
         this._rendererVO = ClanProfileProvinceVO(param1);
         invalidateData();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._toolTipMgr = App.toolTipMgr;
         this._commons = App.utils.commons;
         this._commons.updateChildrenMouseEnabled(this,false);
         this.province.mouseEnabled = true;
         this.map.mouseEnabled = true;
         this.robbedIcon.mouseEnabled = true;
         mouseChildren = enabled;
         this.province.addEventListener(MouseEvent.ROLL_OVER,this.onProvinceRollOverHandler);
         this.province.addEventListener(MouseEvent.ROLL_OUT,this.onCmpRollOutHandler);
         this.map.addEventListener(MouseEvent.ROLL_OVER,this.onMapRollOverHandler);
         this.map.addEventListener(MouseEvent.ROLL_OUT,this.onCmpRollOutHandler);
         this.robbedIcon.visible = false;
         this.robbedIcon.icoType = InfoIcon.TYPE_ROBBED;
      }
      
      override protected function onDispose() : void
      {
         this.province.removeEventListener(MouseEvent.ROLL_OVER,this.onProvinceRollOverHandler);
         this.province.removeEventListener(MouseEvent.ROLL_OUT,this.onCmpRollOutHandler);
         this.province = null;
         this.map.removeEventListener(MouseEvent.ROLL_OVER,this.onMapRollOverHandler);
         this.map.removeEventListener(MouseEvent.ROLL_OUT,this.onCmpRollOutHandler);
         this.map = null;
         this.robbedIcon.dispose();
         this.robbedIcon = null;
         this.front = null;
         this.primeTime = null;
         this.days = null;
         this._rendererVO = null;
         this._toolTipMgr = null;
         this._commons = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         super.draw();
         if(this._rendererVO && isInvalid(InvalidationType.DATA))
         {
            _loc1_ = this._rendererVO.isRobbed;
            this.robbedIcon.visible = _loc1_;
            this.province.width = !!_loc1_ ? Number(PROVINCE_ROBBED_WIDTH) : Number(PROVINCE_NORMAL_WIDTH);
            this._commons.truncateTextFieldText(this.province,this._rendererVO.province);
            if(_loc1_)
            {
               this.robbedIcon.tooltip = this._rendererVO.robbedTooltip;
               this.robbedIcon.x = this.province.x + this.province.textWidth + ROBBED_ICON_GAP;
            }
            this._commons.truncateTextFieldText(this.map,this._rendererVO.map);
            this.front.htmlText = this._rendererVO.front;
            this.primeTime.htmlText = this._rendererVO.primeTime;
            this.days.htmlText = this._rendererVO.days;
         }
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         super.enabled = param1;
         mouseChildren = param1;
      }
      
      private function onCmpRollOutHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.hide();
      }
      
      private function onMapRollOverHandler(param1:MouseEvent) : void
      {
         if(this.map.text != this._rendererVO.map)
         {
            this._toolTipMgr.show(this._rendererVO.map);
         }
      }
      
      private function onProvinceRollOverHandler(param1:MouseEvent) : void
      {
         if(this.province.text != this._rendererVO.province)
         {
            this._toolTipMgr.show(this._rendererVO.province);
         }
      }
   }
}
