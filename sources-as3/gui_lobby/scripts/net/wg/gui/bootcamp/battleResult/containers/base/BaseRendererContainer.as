package net.wg.gui.bootcamp.battleResult.containers.base
{
   import flash.events.Event;
   import flash.events.MouseEvent;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.bootcamp.battleResult.data.BattleItemRendererVO;
   import net.wg.gui.bootcamp.battleResult.events.BattleViewEvent;
   import net.wg.gui.bootcamp.battleResult.interfaces.IBattleResultRenderer;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.entity.IUpdatable;
   import scaleform.clik.constants.InvalidationType;
   
   public class BaseRendererContainer extends UIComponentEx implements IUpdatable
   {
       
      
      public var renderer:IBattleResultRenderer = null;
      
      private var _data:BattleItemRendererVO = null;
      
      public function BaseRendererContainer()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
         addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
         mouseEnabled = false;
         stop();
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
         removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
         this._data = null;
         this.renderer.dispose();
         this.renderer = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data && isInvalid(InvalidationType.DATA))
         {
            this.validateData(this._data);
         }
      }
      
      public function showAnimation() : void
      {
         this.play();
         this.renderer.play();
      }
      
      public function update(param1:Object) : void
      {
         this._data = BattleItemRendererVO(param1);
         invalidateData();
      }
      
      protected function validateData(param1:BattleItemRendererVO) : void
      {
         this.renderer.setData(param1);
      }
      
      private function onMouseOverHandler(param1:Event) : void
      {
         dispatchEvent(new BattleViewEvent(BattleViewEvent.TOOLTIP_SHOW,this._data.id,true));
         App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.BOOTCAMP_AWARD_MEDAL,null,this._data.label,this._data.description,this._data.iconTooltip);
      }
      
      private function onMouseOutHandler(param1:Event) : void
      {
         App.toolTipMgr.hide();
      }
   }
}
