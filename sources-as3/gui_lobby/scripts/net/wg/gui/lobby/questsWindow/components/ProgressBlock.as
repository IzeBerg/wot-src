package net.wg.gui.lobby.questsWindow.components
{
   import fl.transitions.easing.Strong;
   import flash.display.MovieClip;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.events.ResizableBlockEvent;
   import net.wg.gui.lobby.questsWindow.VehicleBlock;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.motion.Tween;
   
   public class ProgressBlock extends CommonConditionsBlock
   {
      
      private static const BOTTOM_PADDING:int = 15;
      
      private static const ICON_PADDING:int = 2;
      
      private static const ANIMATION_DURATION:int = 500;
       
      
      public var line:MovieClip;
      
      public var vehicle:VehicleBlock;
      
      public var icon:UILoaderAlt;
      
      private var tweens:Vector.<Tween>;
      
      public function ProgressBlock()
      {
         this.tweens = new Vector.<Tween>();
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         progressElementsContainer.bottomPadding = BOTTOM_PADDING;
         progressElementsContainer.addEventListener(ResizableBlockEvent.READY_FOR_ANIMATION,this.containerAnimationHandler);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:Tween = null;
         progressElementsContainer.removeEventListener(ResizableBlockEvent.READY_FOR_ANIMATION,this.containerAnimationHandler);
         this.line = null;
         this.icon.dispose();
         this.icon = null;
         for each(_loc1_ in this.tweens)
         {
            _loc1_.onComplete = null;
            _loc1_.onChange = null;
            _loc1_.paused = true;
            _loc1_ = null;
         }
         this.tweens.splice(0,this.tweens.length);
         this.tweens = null;
         this.vehicle.dispose();
         this.vehicle = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         if(isInvalid(InvalidationType.DATA) && data)
         {
            if(data.vehicleData)
            {
               this.vehicle.visible = true;
               this.icon.visible = false;
               description.visible = false;
               this.vehicle.setData(data.vehicleData);
            }
            else
            {
               this.vehicle.visible = false;
               this.icon.visible = Boolean(data.iconSource);
               this.icon.source = data.iconSource;
               description.visible = true;
               description.x = Math.round(Boolean(data.iconSource) ? Number(this.icon.width + ICON_PADDING) : Number(0));
               if(data.counterValue || data.showDone)
               {
                  description.width = DEFAULT_WIDTH - description.x;
               }
               else
               {
                  description.width = availableWidth - description.x;
               }
               description.htmlText = data.description;
               description.height = description.textHeight + TEXT_PADDING;
            }
            counter.text = data.counterValue.toString();
            counter.visible = battlesLeftTF.visible = Boolean(data.counterValue && !data.showDone);
            statusMC.visible = data.showDone;
            progressElementsContainer.isReadyForLayout = false;
            progressElementsContainer.setData(data.progressElements);
            progressElementsContainer.validateNow();
            this.layoutBlocks();
         }
      }
      
      override protected function layoutBlocks() : void
      {
         var _loc1_:Number = NaN;
         _loc1_ = 0;
         if(description.visible)
         {
            _loc1_ = Math.round(description.y + description.height + BOTTOM_PADDING);
         }
         else
         {
            _loc1_ = Math.round(this.vehicle.y + this.vehicle.height + BOTTOM_PADDING);
         }
         progressElementsContainer.y = _loc1_;
         var _loc2_:Number = Math.round(_loc1_ + progressElementsContainer.height);
         this.line.y = _loc2_;
         setSize(this.width,_loc2_ + BOTTOM_PADDING);
         isReadyForLayout = true;
      }
      
      private function containerAnimationHandler(param1:ResizableBlockEvent) : void
      {
         var _loc2_:Number = this.line.y + param1.heightDiff;
         this.playResizeAnimation(_loc2_,ANIMATION_DURATION,this.onEndAnimation);
      }
      
      private function playResizeAnimation(param1:Number, param2:Number, param3:Function = null) : void
      {
         var _loc4_:Tween = null;
         var _loc5_:Tween = null;
         for each(_loc4_ in this.tweens)
         {
            _loc4_.onComplete = null;
            _loc4_.paused = true;
            _loc4_ = null;
         }
         this.tweens = Vector.<Tween>([new Tween(param2,this.line,{"y":param1},{
            "paused":false,
            "ease":Strong.easeInOut,
            "onComplete":param3
         })]);
         for each(_loc5_ in this.tweens)
         {
            _loc5_.fastTransform = false;
         }
      }
      
      private function onEndAnimation() : void
      {
         this.layoutBlocks();
         dispatchEvent(new ResizableBlockEvent(ResizableBlockEvent.CONTETNT_WAS_CHANGED));
      }
   }
}
