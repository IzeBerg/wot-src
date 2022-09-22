package net.wg.gui.lobby.storage.categories.cards.configs
{
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.utils.StageSizeBoundaries;
   
   public final class CardConfigs implements IDisposable
   {
      
      private static var _instance:CardConfigs = null;
       
      
      private var _allowCardsResolution:Array;
      
      private var _cardSize:CardSizeConfig = null;
      
      private var _cardImage:CardImageConfig = null;
      
      private var _customizationCardImage:CustomizationCardImageConfig = null;
      
      private var _progressionLevelPosition:ProgressionLevelPositionConfig = null;
      
      private var _disposed:Boolean = false;
      
      public function CardConfigs()
      {
         this._allowCardsResolution = [StageSizeBoundaries.WIDTH_1024,StageSizeBoundaries.WIDTH_1366,StageSizeBoundaries.WIDTH_1600,StageSizeBoundaries.WIDTH_1920];
         super();
         if(_instance)
         {
            throw new Error("Singleton. Use getInstance()");
         }
         _instance = this;
      }
      
      public static function getInstance() : CardConfigs
      {
         if(_instance == null)
         {
            new CardConfigs();
            _instance.initialize();
         }
         return _instance;
      }
      
      private function initialize() : void
      {
         this._cardSize = new CardSizeConfig();
         this._cardSize.initialize();
         this._cardImage = new CardImageConfig();
         this._cardImage.initialize();
         this._customizationCardImage = new CustomizationCardImageConfig();
         this._customizationCardImage.initialize();
         this._progressionLevelPosition = new ProgressionLevelPositionConfig();
         this._progressionLevelPosition.initialize();
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this._cardSize.dispose();
         this._cardSize = null;
         this._cardImage.dispose();
         this._cardImage = null;
         this._customizationCardImage.dispose();
         this._customizationCardImage = null;
         this._progressionLevelPosition.dispose();
         this._progressionLevelPosition = null;
         this._allowCardsResolution.splice(0,this._allowCardsResolution.length);
         this._allowCardsResolution = null;
         _instance = null;
      }
      
      public function get allowCardsResolution() : Array
      {
         return this._allowCardsResolution;
      }
      
      public function get cardSize() : CardSizeConfig
      {
         return this._cardSize;
      }
      
      public function get cardImage() : CardImageConfig
      {
         return this._cardImage;
      }
      
      public function get customizationCardImage() : CustomizationCardImageConfig
      {
         return this._customizationCardImage;
      }
      
      public function get progressionLevelPosition() : ProgressionLevelPositionConfig
      {
         return this._progressionLevelPosition;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
