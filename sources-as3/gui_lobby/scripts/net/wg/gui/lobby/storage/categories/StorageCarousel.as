package net.wg.gui.lobby.storage.categories
{
   import flash.display.InteractiveObject;
   import net.wg.gui.components.carousels.ScrollCarousel;
   import net.wg.gui.lobby.storage.categories.cards.configs.CardConfigs;
   import net.wg.gui.lobby.storage.categories.cards.configs.CardSizeVO;
   import net.wg.infrastructure.interfaces.IFocusChainContainer;
   import net.wg.utils.IStageSizeDependComponent;
   import net.wg.utils.StageSizeBoundaries;
   import scaleform.clik.constants.DirectionMode;
   import scaleform.clik.constants.InvalidationType;
   
   public class StorageCarousel extends ScrollCarousel implements IFocusChainContainer, IStageSizeDependComponent
   {
       
      
      public function StorageCarousel()
      {
