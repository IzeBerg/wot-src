package net.wg.gui.lobby.storage.categories.cards.configs
{
   import flash.geom.Point;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.utils.StageSizeBoundaries;
   
   public class ProgressionLevelPositionConfig implements IDisposable
   {
       
      
      private const FORMFACTOR_SQUARE:String = "FORMFACTOR_SQUARE";
      
      private const FORMFACTOR_RECT1X2:String = "FORMFACTOR_RECT1X2";
      
      private const FORMFACTOR_RECT1X3:String = "FORMFACTOR_RECT1X3";
      
      private const FORMFACTOR_RECT1X4:String = "FORMFACTOR_RECT1X4";
      
      private const FORMFACTOR_RECT1X6:String = "FORMFACTOR_RECT1X6";
      
      private var _customizationProgressionByResolution:Object;
      
      private var _disposed:Boolean = false;
      
      public function ProgressionLevelPositionConfig()
      {
         this._customizationProgressionByResolution = {};
         super();
      }
      
      public function initialize() : void
      {
         this._customizationProgressionByResolution[StageSizeBoundaries.WIDTH_1024] = this._customizationProgressionByResolution[StageSizeBoundaries.WIDTH_1366] = {
            "FORMFACTOR_SQUARE":new Point(160,17),
            "FORMFACTOR_RECT1X2":new Point(209,17)
         };
         this._customizationProgressionByResolution[StageSizeBoundaries.WIDTH_1600] = this._customizationProgressionByResolution[StageSizeBoundaries.WIDTH_1920] = {
            "FORMFACTOR_SQUARE":new Point(194,27),
            "FORMFACTOR_RECT1X2":new Point(259,27)
         };
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this._customizationProgressionByResolution = App.utils.data.cleanupDynamicObject(this._customizationProgressionByResolution);
      }
      
      public function getConfig(param1:int, param2:String) : Point
      {
         var _loc3_:Object = this._customizationProgressionByResolution[param1];
         var _loc4_:String = param2.toUpperCase();
         if(_loc3_.hasOwnProperty(_loc4_))
         {
            return _loc3_[_loc4_];
         }
         return _loc3_[this.FORMFACTOR_RECT1X2];
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
