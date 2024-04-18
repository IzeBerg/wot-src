package net.wg.gui.lobby.battleRoyale
{
   import net.wg.gui.lobby.hangar.tcarousel.TankCarousel;
   import net.wg.gui.lobby.hangar.tcarousel.helper.ITankCarouselHelper;
   
   public class BattleRoyaleTankCarousel extends TankCarousel
   {
       
      
      public function BattleRoyaleTankCarousel()
      {
         super();
         filterCounter.visible = false;
      }
      
      override protected function createSmallHelper() : ITankCarouselHelper
      {
         return new BRSmallTankCarouselHelper();
      }
      
      override protected function createNormalHelper() : ITankCarouselHelper
      {
         return new BRTankCarouselHelper();
      }
   }
}

import net.wg.gui.lobby.hangar.tcarousel.helper.ITankCarouselHelper;
import scaleform.clik.utils.Padding;

class BRTankCarouselHelper implements ITankCarouselHelper
{
   
   private static const PADDING:Padding = new Padding(10);
   
   private static const RENDER_HEIGHT:int = 102;
   
   private static const RENDERER_VISIBLE_HEIGHT:int = 102;
   
   private static const RENDERER_HEIGHT_DIFF:int = RENDER_HEIGHT - RENDERER_VISIBLE_HEIGHT;
    
   
   function BRTankCarouselHelper()
   {
      super();
   }
   
   public function get linkRenderer() : String
   {
      return "BRTankCarouselItemRendererUI";
   }
   
   public function get rendererWidth() : int
   {
      return 162;
   }
   
   public function get rendererHeight() : int
   {
      return RENDER_HEIGHT;
   }
   
   public function get horizontalGap() : int
   {
      return 10;
   }
   
   public function get verticalGap() : int
   {
      return 10;
   }
   
   public function get padding() : Padding
   {
      return PADDING;
   }
   
   public function get rendererVisibleHeight() : int
   {
      return RENDERER_VISIBLE_HEIGHT;
   }
   
   public function get rendererHeightDiff() : int
   {
      return RENDERER_HEIGHT_DIFF;
   }
   
   public function get isSmall() : Boolean
   {
      return false;
   }
}

import net.wg.gui.lobby.hangar.tcarousel.helper.ITankCarouselHelper;
import scaleform.clik.utils.Padding;

class BRSmallTankCarouselHelper implements ITankCarouselHelper
{
   
   private static const PADDING:Padding = new Padding(19,20);
   
   private static const RENDER_HEIGHT:int = 37;
   
   private static const RENDERER_VISIBLE_HEIGHT:int = 37;
   
   private static const RENDERER_HEIGHT_DIFF:int = RENDER_HEIGHT - RENDERER_VISIBLE_HEIGHT;
    
   
   function BRSmallTankCarouselHelper()
   {
      super();
   }
   
   public function get linkRenderer() : String
   {
      return "BRSmallTankCarouselItemRendererUI";
   }
   
   public function get rendererWidth() : int
   {
      return 162;
   }
   
   public function get rendererHeight() : int
   {
      return RENDER_HEIGHT;
   }
   
   public function get horizontalGap() : int
   {
      return 10;
   }
   
   public function get verticalGap() : int
   {
      return 10;
   }
   
   public function get padding() : Padding
   {
      return PADDING;
   }
   
   public function get rendererVisibleHeight() : int
   {
      return RENDERER_VISIBLE_HEIGHT;
   }
   
   public function get rendererHeightDiff() : int
   {
      return RENDERER_HEIGHT_DIFF;
   }
   
   public function get isSmall() : Boolean
   {
      return true;
   }
}
