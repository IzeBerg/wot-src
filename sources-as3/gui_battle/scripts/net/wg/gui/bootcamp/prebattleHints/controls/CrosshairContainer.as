package net.wg.gui.bootcamp.prebattleHints.controls
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.data.constants.ColorSchemeNames;
   import net.wg.infrastructure.events.ColorSchemeEvent;
   import net.wg.infrastructure.interfaces.IColorScheme;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class CrosshairContainer extends MovieClip implements IDisposable
   {
       
      
      public var txtHeader:TextField;
      
      public var txtPenetrationHigh:TextField;
      
      public var txtPenetrationLow:TextField;
      
      public var penetrationLow:MovieClip = null;
      
      public function CrosshairContainer()
      {
         super();
         this.txtHeader.text = BOOTCAMP.PREBATTLE_HINT_PENETRATION_CHANCE;
         this.txtPenetrationHigh.text = BOOTCAMP.PREBATTLE_HINT_PENETRATION_HIGH;
         this.txtPenetrationLow.text = BOOTCAMP.PREBATTLE_HINT_PENETRATION_LOW;
         App.colorSchemeMgr.addEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onColorSchemasUpdatedHandler);
         this.updatePenetrationColor();
      }
      
      public final function dispose() : void
      {
         App.colorSchemeMgr.removeEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onColorSchemasUpdatedHandler);
         this.txtHeader = null;
         this.txtPenetrationHigh = null;
         this.txtPenetrationLow = null;
         this.penetrationLow = null;
      }
      
      private function updatePenetrationColor() : void
      {
         var _loc1_:IColorScheme = App.colorSchemeMgr.getScheme(ColorSchemeNames.RED_PURPLE_SCHEMA);
         this.txtPenetrationLow.textColor = _loc1_.rgb;
         this.penetrationLow.gotoAndStop(_loc1_.aliasColor);
      }
      
      private function onColorSchemasUpdatedHandler(param1:ColorSchemeEvent) : void
      {
         this.updatePenetrationColor();
      }
   }
}
