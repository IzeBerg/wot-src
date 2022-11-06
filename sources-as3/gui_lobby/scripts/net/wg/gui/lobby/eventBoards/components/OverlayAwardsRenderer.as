package net.wg.gui.lobby.eventBoards.components
{
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.generated.EVENTBOARDS_ALIASES;
   import net.wg.gui.components.common.containers.TiledLayout;
   import net.wg.gui.components.containers.GroupEx;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.lobby.eventBoards.data.AwardsListRendererVO;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.controls.ListItemRenderer;
   
   public class OverlayAwardsRenderer extends ListItemRenderer
   {
      
      private static const ICON_POSITION_X:Number = 34;
      
      private static const DESC_POSITION_X:Number = 120;
      
      private static const AWARD_BLOCK_X:Number = 220;
      
      private static const AWARD_BLOCK_Y:Number = 0;
      
      private static const AWARD_WIDTH:Number = 100;
      
      private static const AWARD_HEIGHT:Number = 77;
      
      private static const AWARDS_NUM:Number = 5;
       
      
      public var icon:Image = null;
      
      public var positionDescr:TextField = null;
      
      private var _awards:GroupEx = null;
      
      private var _dataVO:AwardsListRendererVO = null;
      
      private var _toolTipMgr:ITooltipMgr;
      
      public function OverlayAwardsRenderer()
      {
         this._toolTipMgr = App.toolTipMgr;
         super();
         this._awards = new GroupEx();
         this._awards.layout = new TiledLayout(AWARD_WIDTH,AWARD_HEIGHT,AWARDS_NUM);
         this._awards.itemRendererLinkage = EVENTBOARDS_ALIASES.EVENTBOARDS_AWARD_RENDERER_ALIAS;
         addChild(this._awards);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.icon.addEventListener(MouseEvent.MOUSE_OVER,this.onIconMouseOverHandler);
         this.icon.addEventListener(MouseEvent.MOUSE_OUT,this.onIconMouseOutHandler);
         useHandCursor = buttonMode = false;
         mouseChildren = mouseEnabled = true;
      }
      
      override public function setData(param1:Object) : void
      {
         super.setData(param1);
         this._dataVO = AwardsListRendererVO(param1);
         invalidateData();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(_data && isInvalid(InvalidationType.DATA))
         {
            this.positionDescr.htmlText = this._dataVO.positionDescr;
            this.positionDescr.x = DESC_POSITION_X;
            this.icon.source = this._dataVO.icon;
            this.icon.x = ICON_POSITION_X;
            this._awards.dataProvider = this._dataVO.awards;
            this._awards.x = AWARD_BLOCK_X;
            this._awards.y = AWARD_BLOCK_Y;
         }
      }
      
      override protected function onDispose() : void
      {
         if(this.icon != null)
         {
            this.icon.dispose();
            this.icon.removeEventListener(MouseEvent.MOUSE_OVER,this.onIconMouseOverHandler);
            this.icon.removeEventListener(MouseEvent.MOUSE_OUT,this.onIconMouseOutHandler);
            this.icon = null;
         }
         this.positionDescr = null;
         this._awards.dispose();
         this._awards = null;
         this._dataVO = null;
         this._toolTipMgr = null;
         super.onDispose();
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         super.enabled = param1;
         mouseChildren = true;
      }
      
      private function onIconMouseOverHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.show(this._dataVO.tooltip);
      }
      
      private function onIconMouseOutHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.hide();
      }
   }
}
