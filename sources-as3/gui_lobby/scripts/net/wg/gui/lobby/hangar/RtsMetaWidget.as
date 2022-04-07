package net.wg.gui.lobby.hangar
{
   import flash.display.BlendMode;
   import flash.display.MovieClip;
   import flash.events.Event;
   import net.wg.infrastructure.base.meta.IRtsMetaWidgetMeta;
   import net.wg.infrastructure.base.meta.impl.RtsMetaWidgetMeta;
   import net.wg.utils.StageSizeBoundaries;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.motion.Tween;
   
   public class RtsMetaWidget extends RtsMetaWidgetMeta implements IRtsMetaWidgetMeta
   {
      
      private static const Y_OFFSET_BIG:int = 59;
      
      private static const Y_OFFSET_SMALL:int = 54;
      
      private static const SIZE_NORMAL:int = 232;
      
      private static const SPARK_LINKAGE:String = "RtsMetaSpark";
      
      private static const SPARK_SIZE_BIG:int = 250;
      
      private static const SPARK_SIZE_SMALL:int = 165;
      
      private static const SPARK_Y_BIG:int = 100;
      
      private static const SPARK_Y_SMALL:int = 75;
      
      private static const SPARK_TWEEN_DURATION:int = 1000;
       
      
      private var _spark:MovieClip;
      
      private var _sparkTween:Tween;
      
      private var _sparkVisible:Boolean = false;
      
      public function RtsMetaWidget()
      {
         super();
         setSize(SIZE_NORMAL,SIZE_NORMAL);
         App.stage.addEventListener(Event.RESIZE,this.onStageResizeHandler,false,0,true);
         this._spark = App.utils.classFactory.getObject(SPARK_LINKAGE) as MovieClip;
         this._spark.alpha = 0;
         this._spark.blendMode = BlendMode.ADD;
         addChild(this._spark);
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:int = 0;
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            _loc1_ = App.stage.stageWidth < StageSizeBoundaries.WIDTH_1366;
            _loc2_ = !!_loc1_ ? int(Y_OFFSET_SMALL) : int(Y_OFFSET_BIG);
            x = -(width >> 1);
            y = _loc2_;
            this._spark.width = this._spark.height = !!_loc1_ ? Number(SPARK_SIZE_SMALL) : Number(SPARK_SIZE_BIG);
            this._spark.x = width >> 1;
            this._spark.y = !!_loc1_ ? Number(SPARK_Y_SMALL) : Number(SPARK_Y_BIG);
         }
      }
      
      override protected function onDispose() : void
      {
         App.stage.removeEventListener(Event.RESIZE,this.onStageResizeHandler);
         if(this._sparkTween)
         {
            this._sparkTween.dispose();
            this._sparkTween = null;
         }
         if(this._spark)
         {
            removeChild(this._spark);
            this._spark = null;
         }
         super.onDispose();
      }
      
      private function onStageResizeHandler(param1:Event) : void
      {
         invalidateSize();
      }
      
      public function as_setSparkVisible(param1:Boolean) : void
      {
         if(param1 == this._sparkVisible)
         {
            return;
         }
         this._sparkVisible = param1;
         this._sparkTween = new Tween(SPARK_TWEEN_DURATION,this._spark,{"alpha":(!!this._sparkVisible ? 1 : 0)},{"paused":false});
      }
   }
}
