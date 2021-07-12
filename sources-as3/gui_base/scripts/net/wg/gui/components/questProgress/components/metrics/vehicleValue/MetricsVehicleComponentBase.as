package net.wg.gui.components.questProgress.components.metrics.vehicleValue
{
   import net.wg.data.constants.Linkages;
   import net.wg.gui.components.questProgress.QuestProgressAtlasSprite;
   import net.wg.gui.components.questProgress.components.metrics.QPMetricsCmptBase;
   import net.wg.gui.components.questProgress.data.metrics.QPMetricsVehicleVO;
   import net.wg.gui.components.questProgress.interfaces.data.IQPMetrics;
   
   public class MetricsVehicleComponentBase extends QPMetricsCmptBase
   {
      
      protected static const ICONS_WIDTH:int = 15;
       
      
      protected var vehicles:Vector.<QuestProgressAtlasSprite> = null;
      
      private var _pool:Vector.<QuestProgressAtlasSprite> = null;
      
      private var _imageYPosLine:int = 0;
      
      public function MetricsVehicleComponentBase()
      {
         super();
      }
      
      override protected final function onInit(param1:IQPMetrics) : void
      {
         this.doInit(QPMetricsVehicleVO(param1));
         super.onInit(param1);
      }
      
      override protected final function onUpdate(param1:IQPMetrics) : void
      {
         this.doUpdate(QPMetricsVehicleVO(param1));
         super.onUpdate(param1);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:QuestProgressAtlasSprite = null;
         if(this.vehicles)
         {
            for each(_loc1_ in this.vehicles)
            {
               this.removeChild(_loc1_);
            }
            this.vehicles.splice(0,this.vehicles.length);
            this.vehicles = null;
         }
         if(this._pool)
         {
            this._pool.splice(0,this._pool.length);
            this._pool = null;
         }
         super.onDispose();
      }
      
      override protected function doUpdateState(param1:int) : void
      {
         var _loc3_:QuestProgressAtlasSprite = null;
         var _loc2_:Boolean = isCompleted;
         for each(_loc3_ in this.vehicles)
         {
            _loc3_.visible = !_loc2_;
         }
         super.doUpdateState(param1);
      }
      
      protected function doInit(param1:QPMetricsVehicleVO) : void
      {
         this.vehicles = new Vector.<QuestProgressAtlasSprite>();
         this._pool = new Vector.<QuestProgressAtlasSprite>();
         this.updateVehicles(param1.vehicleTypes);
      }
      
      protected function doUpdate(param1:QPMetricsVehicleVO) : void
      {
         this.updateVehicles(param1.vehicleTypes);
      }
      
      private function updateVehicles(param1:Vector.<String>) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = param1.length;
         var _loc4_:int = _loc3_ - this.vehicles.length;
         if(_loc4_ > 0)
         {
            _loc2_ = 0;
            while(_loc2_ < _loc4_)
            {
               this.vehicles.push(this.getCmpnt());
               _loc2_++;
            }
         }
         else if(_loc4_ < 0)
         {
            _loc4_ *= -1;
            _loc2_ = 0;
            while(_loc2_ < _loc4_)
            {
               this.removeCmpnt(this.vehicles.pop());
               _loc2_++;
            }
         }
         _loc4_ = this.vehicles.length;
         _loc2_ = 0;
         while(_loc2_ < _loc4_)
         {
            this.vehicles[_loc2_].imageName = param1[_loc2_];
            _loc2_++;
         }
      }
      
      private function getCmpnt() : QuestProgressAtlasSprite
      {
         var _loc1_:QuestProgressAtlasSprite = null;
         if(this._pool.length)
         {
            _loc1_ = this._pool.pop();
         }
         else
         {
            _loc1_ = App.utils.classFactory.getComponent(Linkages.QP_ATLAS_SPRITE,QuestProgressAtlasSprite);
            _loc1_.isCentralize = true;
            _loc1_.y = this._imageYPosLine;
         }
         this.addChild(_loc1_);
         return _loc1_;
      }
      
      private function removeCmpnt(param1:QuestProgressAtlasSprite) : void
      {
         this.removeChild(param1);
         this._pool.push(param1);
      }
      
      public function set imageYPosLine(param1:int) : void
      {
         this._imageYPosLine = param1;
      }
   }
}
