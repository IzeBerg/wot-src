package net.wg.gui.lobby.hangar
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.infrastructure.base.meta.ITmenXpPanelMeta;
   import net.wg.infrastructure.base.meta.impl.TmenXpPanelMeta;
   
   public class TmenXpPanel extends TmenXpPanelMeta implements ITmenXpPanelMeta
   {
      
      private static const INVALIDATE_XP_PANEL:String = "invXpPanel";
       
      
      public var checkboxTankersBg:MovieClip;
      
      public var xpToTmenDescriptionTf:TextField;
      
      private var _panelVisible:Boolean = false;
      
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
      
      public function as_setTankmenXpPanel(param1:Boolean) : void
      {
         this.panelVisible = param1;
         invalidate(INVALIDATE_XP_PANEL);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.checkboxTankersBg.visible = this.xpToTmenDescriptionTf.visible = false;
         this.xpToTmenDescriptionTf.autoSize = TextFieldAutoSize.LEFT;
         this.xpToTmenDescriptionTf.htmlText = MENU.HANGAR_XPTOTMENCHECKBOX_TITLE;
         addEventListener(MouseEvent.ROLL_OVER,showXpTankmenTooltip);
         addEventListener(MouseEvent.ROLL_OUT,hideXpTankmenTooltip);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(INVALIDATE_XP_PANEL))
         {
            this.checkboxTankersBg.visible = this.xpToTmenDescriptionTf.visible = this.panelVisible;
         }
      }
      
      override protected function onDispose() : void
      {
         App.toolTipMgr.hide();
         this.checkboxTankersBg = null;
         removeEventListener(MouseEvent.ROLL_OVER,showXpTankmenTooltip);
         removeEventListener(MouseEvent.ROLL_OUT,hideXpTankmenTooltip);
         this.xpToTmenDescriptionTf = null;
         super.onDispose();
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
