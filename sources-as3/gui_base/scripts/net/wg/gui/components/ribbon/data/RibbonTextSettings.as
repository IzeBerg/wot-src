package net.wg.gui.components.ribbon.data
{
   import net.wg.gui.components.ribbon.constants.RibbonColors;
   import net.wg.infrastructure.managers.IColorSchemeManager;
   
   public class RibbonTextSettings
   {
      
      private static const GREEN_RIBBON_TEXT_COLOR:String = "ribbonGreenText";
      
      private static const GREEN_SHADOW_COLOR:String = "ribbonGreenShadow";
      
      private static const GREY_RIBBON_TEXT_COLOR:String = "ribbonGreyText";
      
      private static const GREY_RIBBON_SHADOW_COLOR:String = "ribbonGreyShadow";
      
      private static const ORANGE_RIBBON_SHADOW_COLOR:String = "ribbonOrangeShadow";
      
      private static const YELLOW_RIBBON_SHADOW_COLOR:String = "ribbonYellowShadow";
      
      private static const RED_RIBBON_SHADOW_COLOR:String = "ribbonRedShadow";
      
      private static const PURPLE_RIBBON_SHADOW_COLOR:String = "ribbonPurpleShadow";
      
      private static const PERK_TEXT_COLOR:String = "ribbonPerkValueText";
      
      private static const PERK_SHADOW_COLOR:String = "ribbonPerkShadow";
      
      public static const SHADOW_BLUR:Number = 5;
      
      public static const SHADOW_STRENGTH:Number = 1.5;
      
      public static const SHADOW_ALPHA:Number = 1;
      
      public static const SHADOW_DISTANCE:Number = 0;
       
      
      private var _ribbonNameTextColor:uint = 0;
      
      private var _valueTextColor:uint = 0;
      
      private var _shadowColor:uint = 0;
      
      public function RibbonTextSettings(param1:String)
      {
         super();
         this.update(param1);
      }
      
      public function update(param1:String) : void
      {
         var _loc2_:IColorSchemeManager = App.colorSchemeMgr;
         var _loc3_:Number = _loc2_.getRGB(GREY_RIBBON_TEXT_COLOR);
         switch(param1)
         {
            case RibbonColors.GREY:
               this._valueTextColor = _loc3_;
               this._shadowColor = _loc2_.getRGB(GREY_RIBBON_SHADOW_COLOR);
               this._ribbonNameTextColor = _loc3_;
               break;
            case RibbonColors.GREEN:
               this._valueTextColor = _loc2_.getRGB(GREEN_RIBBON_TEXT_COLOR);
               this._shadowColor = _loc2_.getRGB(GREEN_SHADOW_COLOR);
               this._ribbonNameTextColor = this._valueTextColor;
               break;
            case RibbonColors.RED:
               this._valueTextColor = _loc3_;
               this._shadowColor = _loc2_.getRGB(RED_RIBBON_SHADOW_COLOR);
               this._ribbonNameTextColor = _loc3_;
               break;
            case RibbonColors.ORANGE:
               this._valueTextColor = _loc3_;
               this._shadowColor = _loc2_.getRGB(ORANGE_RIBBON_SHADOW_COLOR);
               this._ribbonNameTextColor = _loc3_;
               break;
            case RibbonColors.YELLOW:
               this._valueTextColor = _loc3_;
               this._shadowColor = _loc2_.getRGB(YELLOW_RIBBON_SHADOW_COLOR);
               this._ribbonNameTextColor = _loc3_;
               break;
            case RibbonColors.PURPLE:
               this._valueTextColor = _loc3_;
               this._shadowColor = _loc2_.getRGB(PURPLE_RIBBON_SHADOW_COLOR);
               this._ribbonNameTextColor = _loc3_;
               break;
            case RibbonColors.PERK:
               this._valueTextColor = _loc2_.getRGB(PERK_TEXT_COLOR);
               this._shadowColor = _loc2_.getRGB(PERK_SHADOW_COLOR);
               this._ribbonNameTextColor = _loc2_.getRGB(PERK_TEXT_COLOR);
               break;
            default:
               App.utils.asserter.assert(false,"No such rendererType: " + param1);
         }
      }
      
      public function get valueTextColor() : uint
      {
         return this._valueTextColor;
      }
      
      public function get shadowColor() : uint
      {
         return this._shadowColor;
      }
      
      public function get ribbonNameTextColor() : uint
      {
         return this._ribbonNameTextColor;
      }
   }
}
