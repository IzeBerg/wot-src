package net.wg.gui.lobby.missions.components.detailedView
{
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.gui.lobby.missions.data.MissionBattleRequirementRendererVO;
   import net.wg.infrastructure.interfaces.entity.IUpdatable;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.controls.ListItemRenderer;
   
   public class MissionBattleRequirementRenderer extends ListItemRenderer implements IUpdatable
   {
      
      private static const LABEL_GAP:int = 40;
       
      
      public var labelTf:TextField;
      
      private var _vo:MissionBattleRequirementRendererVO;
      
      public function MissionBattleRequirementRenderer()
      {
         super();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(_data && isInvalid(InvalidationType.DATA))
         {
            this.labelTf.htmlText = this._vo.label;
            App.utils.commons.updateTextFieldSize(this.labelTf,true,false);
            this.labelTf.x = -this.labelTf.width >> 1 - LABEL_GAP;
         }
      }
      
      override protected function onDispose() : void
      {
         this.labelTf = null;
         this._vo = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         buttonMode = false;
         mouseEnabled = true;
      }
      
      public function update(param1:Object) : void
      {
         super.data = param1;
         this._vo = MissionBattleRequirementRendererVO(param1);
         invalidateData();
      }
      
      override public function get width() : Number
      {
         if(this.labelTf)
         {
            return this.labelTf.textWidth;
         }
         return super.width;
      }
      
      override protected function handleMouseRollOut(param1:MouseEvent) : void
      {
         super.handleMouseRollOut(param1);
         App.toolTipMgr.hide();
      }
      
      override protected function handleMouseRollOver(param1:MouseEvent) : void
      {
         super.handleMouseRollOver(param1);
         App.toolTipMgr.showComplex(this._vo.tooltip);
      }
   }
}
