package net.wg.gui.lobby.hangar
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import net.wg.gui.components.controls.CheckBox;
   import net.wg.infrastructure.base.meta.ITmenXpPanelMeta;
   import net.wg.infrastructure.base.meta.impl.TmenXpPanelMeta;
   import scaleform.clik.events.ButtonEvent;
   
   public class TmenXpPanel extends TmenXpPanelMeta implements ITmenXpPanelMeta
   {
      
      private static const INVALIDATE_XP_PANEL:String = "invXpPanel";
       
      
      public var checkboxTankersBg:MovieClip;
      
      public var xpToTmenCheckbox:CheckBox;
      
      private var _panelVisible:Boolean = false;
      
      private var _panelSelected:Boolean = false;
      
      public function TmenXpPanel()
      {
         super();
      }
      
      private static function showXpTankmenTooltip(param1:MouseEvent) : void
      {
         App.toolTipMgr.showComplex(TOOLTIPS.HANGAR_XPTOTMENCHECKBOX);
      }
      
      private static function hideXpTankmenTooltip(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      public function as_setTankmenXpPanel(param1:Boolean, param2:Boolean) : void
      {
         this.panelVisible = param1;
         this._panelSelected = param2;
         invalidate(INVALIDATE_XP_PANEL);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.checkboxTankersBg.visible = this.xpToTmenCheckbox.visible = false;
         this.xpToTmenCheckbox.label = DIALOGS.XPTOTMENCHECKBOX_TITLE;
         this.xpToTmenCheckbox.addEventListener(MouseEvent.ROLL_OVER,showXpTankmenTooltip);
         this.xpToTmenCheckbox.addEventListener(MouseEvent.ROLL_OUT,hideXpTankmenTooltip);
         this.xpToTmenCheckbox.addEventListener(ButtonEvent.CLICK,this.onXpToTmenCheckboxClick);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(INVALIDATE_XP_PANEL))
         {
            this.checkboxTankersBg.visible = this.xpToTmenCheckbox.visible = this.panelVisible;
            this.xpToTmenCheckbox.selected = this._panelSelected;
         }
      }
      
      override protected function onDispose() : void
      {
         App.toolTipMgr.hide();
         this.xpToTmenCheckbox.removeEventListener(MouseEvent.ROLL_OVER,showXpTankmenTooltip);
         this.xpToTmenCheckbox.removeEventListener(MouseEvent.ROLL_OUT,hideXpTankmenTooltip);
         this.xpToTmenCheckbox.removeEventListener(ButtonEvent.CLICK,this.onXpToTmenCheckboxClick);
         this.checkboxTankersBg = null;
         this.xpToTmenCheckbox.dispose();
         this.xpToTmenCheckbox = null;
         super.onDispose();
      }
      
      private function onXpToTmenCheckboxClick(param1:ButtonEvent) : void
      {
         App.toolTipMgr.hide();
         DebugUtils.LOG_DEBUG(this.xpToTmenCheckbox.selected);
         accelerateTmenXpS(this.xpToTmenCheckbox.selected);
      }
      
      public function get panelVisible() : Boolean
      {
         return this._panelVisible;
      }
      
      public function set panelVisible(param1:Boolean) : void
      {
         this._panelVisible = param1;
      }
   }
}
