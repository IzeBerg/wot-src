package net.wg.gui.lobby.storage.categories.cards.configs
{
   import flash.geom.Rectangle;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.utils.StageSizeBoundaries;
   
   public class CardSizeConfig implements IDisposable
   {
       
      
      private var _settingsByResolution:Object;
      
      public function CardSizeConfig()
      {
         this._settingsByResolution = {};
         super();
      }
      
      public function initialize() : void
      {
         this._settingsByResolution[StageSizeBoundaries.WIDTH_1024] = this._settingsByResolution[StageSizeBoundaries.WIDTH_1366] = new CardSizeVO(new Rectangle(0,0,260,171),new Rectangle(12,12,260 - 8 - 12 - 2,171 - 8 - 12 - 2),16,0,0);
         this._settingsByResolution[StageSizeBoundaries.WIDTH_1600] = this._settingsByResolution[StageSizeBoundaries.WIDTH_1920] = new CardSizeVO(new Rectangle(0,0,312,205),new Rectangle(12,12,312 - 14 - 12,205 - 11 - 12),19,0,8);
      }
      
      public final function dispose() : void
      {
         this._settingsByResolution = App.utils.data.cleanupDynamicObject(this._settingsByResolution);
      }
      
      public function getConfig(param1:int) : CardSizeVO
      {
         return this._settingsByResolution[param1];
      }
   }
}
