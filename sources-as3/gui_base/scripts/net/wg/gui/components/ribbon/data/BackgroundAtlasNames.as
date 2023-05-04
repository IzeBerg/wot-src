package net.wg.gui.components.ribbon.data
{
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.data.constants.generated.COMMONBATTLELOBBY;
   import net.wg.gui.components.ribbon.constants.RibbonColors;
   
   public class BackgroundAtlasNames
   {
       
      
      protected var _small:String;
      
      protected var _medium:String;
      
      protected var _large:String;
      
      public function BackgroundAtlasNames(param1:String)
      {
         super();
         this.update(param1);
      }
      
      public function update(param1:String) : void
      {
         switch(param1)
         {
            case RibbonColors.GREY:
               this._small = BATTLEATLAS.RIBBONS_BG_GREY_SMALL;
               this._medium = BATTLEATLAS.RIBBONS_BG_GREY_MEDIUM;
               this._large = BATTLEATLAS.RIBBONS_BG_GREY_LARGE;
               break;
            case RibbonColors.GREEN:
               this._small = BATTLEATLAS.RIBBONS_BG_GREEN_SMALL;
               this._medium = BATTLEATLAS.RIBBONS_BG_GREEN_MEDIUM;
               this._large = BATTLEATLAS.RIBBONS_BG_GREEN_LARGE;
               break;
            case RibbonColors.RED:
               this._small = BATTLEATLAS.RIBBONS_BG_RED_SMALL;
               this._medium = BATTLEATLAS.RIBBONS_BG_RED_MEDIUM;
               this._large = BATTLEATLAS.RIBBONS_BG_RED_LARGE;
               break;
            case RibbonColors.ORANGE:
               this._small = BATTLEATLAS.RIBBONS_BG_ORANGE_SMALL;
               this._medium = BATTLEATLAS.RIBBONS_BG_ORANGE_MEDIUM;
               this._large = BATTLEATLAS.RIBBONS_BG_ORANGE_LARGE;
               break;
            case RibbonColors.YELLOW:
               this._small = BATTLEATLAS.RIBBONS_BG_YELLOW_SMALL;
               this._medium = BATTLEATLAS.RIBBONS_BG_YELLOW_MEDIUM;
               this._large = BATTLEATLAS.RIBBONS_BG_YELLOW_LARGE;
               break;
            case RibbonColors.PURPLE:
               this._small = BATTLEATLAS.RIBBONS_BG_PURPLE_SMALL;
               this._medium = BATTLEATLAS.RIBBONS_BG_PURPLE_MEDIUM;
               this._large = BATTLEATLAS.RIBBONS_BG_PURPLE_LARGE;
               break;
            case RibbonColors.PERK:
               this._small = COMMONBATTLELOBBY.RIBBONS_BG_PERK_SMALL;
               this._medium = COMMONBATTLELOBBY.RIBBONS_BG_PERK_MEDIUM;
               this._large = COMMONBATTLELOBBY.RIBBONS_BG_PERK_LARGE;
         }
      }
      
      public function get small() : String
      {
         return this._small;
      }
      
      public function get medium() : String
      {
         return this._medium;
      }
      
      public function get large() : String
      {
         return this._large;
      }
   }
}
