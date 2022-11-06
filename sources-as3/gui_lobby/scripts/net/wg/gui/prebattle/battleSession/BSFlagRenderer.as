package net.wg.gui.prebattle.battleSession
{
   import flash.events.MouseEvent;
   import net.wg.gui.components.controls.SoundListItemRenderer;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.infrastructure.managers.ITooltipMgr;
   
   public class BSFlagRenderer extends SoundListItemRenderer
   {
       
      
      public var loader:UILoaderAlt;
      
      private var _vo:BSFlagRendererVO = null;
      
      private var _tooltipMgr:ITooltipMgr = null;
      
      public function BSFlagRenderer()
      {
         super();
         buttonMode = false;
         this._tooltipMgr = App.toolTipMgr;
         this.loader.hideLoader = false;
      }
      
      override public function setData(param1:Object) : void
      {
         if(param1 == null)
         {
            return;
         }
         super.setData(param1);
         this._vo = BSFlagRendererVO(param1);
         var _loc2_:String = this._vo.icon;
         if(_loc2_)
         {
            this.loader.source = _loc2_;
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.loader.mouseChildren = false;
         this.loader.buttonMode = false;
      }
      
      override protected function onDispose() : void
      {
         this.loader.dispose();
         this.loader = null;
         this._vo = null;
         this._tooltipMgr = null;
         super.onDispose();
      }
      
      override protected function handleMouseRollOver(param1:MouseEvent) : void
      {
         super.handleMouseRollOver(param1);
         this._tooltipMgr.show(this._vo.tooltip);
      }
      
      override protected function handleMouseRollOut(param1:MouseEvent) : void
      {
         super.handleMouseRollOut(param1);
         this._tooltipMgr.hide();
      }
   }
}
