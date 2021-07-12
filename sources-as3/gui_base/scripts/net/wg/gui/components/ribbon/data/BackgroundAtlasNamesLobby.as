package net.wg.gui.components.ribbon.data
{
   import net.wg.data.constants.generated.COMMONBATTLELOBBY;
   import net.wg.gui.components.ribbon.constants.RibbonColors;
   
   public class BackgroundAtlasNamesLobby extends BackgroundAtlasNames
   {
       
      
      public function BackgroundAtlasNamesLobby(param1:String)
      {
         super(param1);
      }
      
      override public function update(param1:String) : void
      {
         switch(param1)
         {
            case RibbonColors.GREY:
               _small = COMMONBATTLELOBBY.RIBBONS_BG_GREY_SMALL;
               _medium = COMMONBATTLELOBBY.RIBBONS_BG_GREY_MEDIUM;
               _large = COMMONBATTLELOBBY.RIBBONS_BG_GREY_LARGE;
               break;
            case RibbonColors.GREEN:
               _small = COMMONBATTLELOBBY.RIBBONS_BG_GREEN_SMALL;
               _medium = COMMONBATTLELOBBY.RIBBONS_BG_GREEN_MEDIUM;
               _large = COMMONBATTLELOBBY.RIBBONS_BG_GREEN_LARGE;
               break;
            case RibbonColors.RED:
               _small = COMMONBATTLELOBBY.RIBBONS_BG_RED_SMALL;
               _medium = COMMONBATTLELOBBY.RIBBONS_BG_RED_MEDIUM;
               _large = COMMONBATTLELOBBY.RIBBONS_BG_RED_LARGE;
               break;
            case RibbonColors.ORANGE:
               _small = COMMONBATTLELOBBY.RIBBONS_BG_ORANGE_SMALL;
               _medium = COMMONBATTLELOBBY.RIBBONS_BG_ORANGE_MEDIUM;
               _large = COMMONBATTLELOBBY.RIBBONS_BG_ORANGE_LARGE;
               break;
            case RibbonColors.YELLOW:
               _small = COMMONBATTLELOBBY.RIBBONS_BG_YELLOW_SMALL;
               _medium = COMMONBATTLELOBBY.RIBBONS_BG_YELLOW_MEDIUM;
               _large = COMMONBATTLELOBBY.RIBBONS_BG_YELLOW_LARGE;
               break;
            case RibbonColors.PURPLE:
               _small = COMMONBATTLELOBBY.RIBBONS_BG_PURPLE_SMALL;
               _medium = COMMONBATTLELOBBY.RIBBONS_BG_PURPLE_MEDIUM;
               _large = COMMONBATTLELOBBY.RIBBONS_BG_PURPLE_LARGE;
         }
      }
   }
}
