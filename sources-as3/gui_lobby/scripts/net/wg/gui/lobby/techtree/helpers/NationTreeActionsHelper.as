package net.wg.gui.lobby.techtree.helpers
{
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.geom.Point;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.components.advanced.events.TutorialHintEvent;
   import net.wg.gui.components.advanced.tutorial.TutorialHint;
   import net.wg.gui.components.advanced.vo.TutorialHintVO;
   import net.wg.gui.lobby.techtree.TechTreeEvent;
   import net.wg.gui.lobby.techtree.data.vo.NTDisplayInfo;
   import net.wg.gui.lobby.techtree.data.vo.NodeData;
   import net.wg.gui.lobby.techtree.interfaces.IRenderer;
   import net.wg.gui.lobby.techtree.nodes.NationTreeNode;
   import net.wg.gui.utils.FrameHelper;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.infrastructure.tutorial.builders.TutorialHintBuilder;
   import net.wg.utils.IScheduler;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class NationTreeActionsHelper implements IDisposable
   {
      
      private static const ANIM_FRAME_TIME:int = 100;
      
      private static const ANIM_TIME_OUT:int = 300;
      
      private static const ARROW_ANIMATION_START_TIMEOUT:int = 400;
      
      private static const EMPTY_POINT:Point = new Point();
      
      private static const LABEL_END_ANIM:String = "animEnd";
       
      
      private var _scheduler:IScheduler;
      
      private var _isFirstTimeActionShow:Boolean = false;
      
      private var _techTreeEventStartColumn:uint;
      
      private var _hint:TutorialHint = null;
      
      private var _hintTarget:MovieClip = null;
      
      private var _hintModel:TutorialHintVO = null;
      
      private var _hintParent:DisplayObjectContainer = null;
      
      private var _animFrameHelper:FrameHelper = null;
      
      private var _sequence:Vector.<AnimSequenceItem>;
      
      public function NationTreeActionsHelper()
      {
         this._scheduler = App.utils.scheduler;
         this._sequence = new Vector.<AnimSequenceItem>();
         super();
      }
      
      public function dispose() : void
      {
         this._scheduler = null;
         this._hintTarget = null;
         if(this._animFrameHelper)
         {
            this._animFrameHelper.dispose();
            this._animFrameHelper = null;
         }
         if(this._hint)
         {
            this._hint.dispose();
            this._hint = null;
         }
         if(this._hintModel)
         {
            this._hintModel.dispose();
            this._hintModel = null;
         }
         this.clearAnimSequence();
         this._sequence = null;
         this._hintParent = null;
      }
      
      public function reset() : void
      {
         if(this._scheduler)
         {
            this._scheduler.cancelTask(this.startAnimation);
         }
         if(this._animFrameHelper)
         {
            this._animFrameHelper.clearFrameScripts();
         }
         this.clearAnimSequence();
         if(this._hint)
         {
            this._hint.removeEventListener(TutorialHintEvent.ANIMATION_ENDED,this.onHintAnimationEndedHandler);
            this._hint.visible = false;
            this._hint.hide();
         }
         this._isFirstTimeActionShow = false;
         this._techTreeEventStartColumn = 0;
      }
      
      public function setupRenderer(param1:IRenderer, param2:NodeData, param3:DisplayObjectContainer) : void
      {
         var _loc4_:NTDisplayInfo = param2.displayInfo as NTDisplayInfo;
         var _loc5_:String = param2.actionMessage;
         var _loc6_:Boolean = StringUtils.isNotEmpty(_loc5_);
         var _loc7_:NationTreeNode = param1 as NationTreeNode;
         if(_loc6_)
         {
            this._isFirstTimeActionShow = _loc6_;
            if(_loc4_)
            {
               this._techTreeEventStartColumn = _loc4_.column;
            }
            this._hintTarget = _loc7_.hit;
            this.prepareHintModel(param2.actionMessage);
            if(this._hint)
            {
               this._hint.model = this._hintModel;
            }
            else
            {
               this._hint = App.utils.classFactory.getComponent(Linkages.TUTORIAL_HINT_UI,TutorialHint,{"model":this._hintModel});
            }
            this._hintParent = param3;
            this._hint.addEventListener(TutorialHintEvent.ANIMATION_ENDED,this.onHintAnimationEndedHandler);
         }
         if(_loc7_)
         {
            _loc7_.resetNationTreeEventAnimation();
            _loc7_.isFirstTimeActionShow = this._isFirstTimeActionShow;
         }
         if(this._isFirstTimeActionShow && param2.hasTechTreeEvent && _loc4_)
         {
            this.prepareActionAnimation(_loc7_,_loc4_.column - this._techTreeEventStartColumn,_loc6_,param2.isTopActionNode);
         }
      }
      
      public function updateLayouts() : void
      {
         this.layoutHint();
      }
      
      private function clearAnimSequence() : void
      {
         var _loc1_:AnimSequenceItem = null;
         if(this._sequence)
         {
            for each(_loc1_ in this._sequence)
            {
               _loc1_.dispose();
            }
            this._sequence.splice(0,this._sequence.length);
         }
      }
      
      private function prepareActionAnimation(param1:NationTreeNode, param2:int, param3:Boolean = false, param4:Boolean = false) : void
      {
         if(param3)
         {
            this._scheduler.scheduleTask(this.startAnimation,ARROW_ANIMATION_START_TIMEOUT);
         }
         this._sequence.push(new AnimSequenceItem(param1.animateFrameHighlight,ANIM_FRAME_TIME));
         this._sequence.push(new AnimSequenceItem(param1.animateNationTreeEvent,param2 * ANIM_TIME_OUT));
         if(param4)
         {
            if(this._animFrameHelper)
            {
               this._animFrameHelper.setTarget(param1.techTreeEventAnimMc);
            }
            else
            {
               this._animFrameHelper = new FrameHelper(param1.techTreeEventAnimMc);
            }
            this._animFrameHelper.addScriptToFrame(this._animFrameHelper.getFrameByLabel(LABEL_END_ANIM),this.onEndAnimation);
         }
      }
      
      private function startAnimation() : void
      {
         this._hint.show();
         this._hintParent.dispatchEvent(new TechTreeEvent(TechTreeEvent.ON_START_HINT_ANIMATION));
         this.layoutHint();
         this._hintParent.addChild(this._hint);
         this._hint.visible = true;
      }
      
      private function prepareHintModel(param1:String) : void
      {
         if(this._hintModel)
         {
            this._hintModel.hintText = param1;
         }
         else
         {
            this._hintModel = new TutorialHintVO({
               "hasBox":false,
               "hasArrow":true,
               "arrowLoop":true,
               "hintText":param1,
               "padding":{
                  "left":0,
                  "right":0,
                  "top":50,
                  "bottom":0
               }
            });
         }
      }
      
      private function layoutHint() : void
      {
         if(this._hintTarget == null)
         {
            return;
         }
         var _loc1_:Point = this._hintTarget.localToGlobal(EMPTY_POINT);
         _loc1_ = this._hintParent.globalToLocal(_loc1_);
         var _loc2_:Number = Number(this._hintTarget.scaleX) || Number(1);
         var _loc3_:Number = Number(this._hintTarget.scaleY) || Number(1);
         this._hint.x = _loc1_.x - TutorialHintBuilder.HINT_GLOW_OFFSET + this._hintModel.padding.left * _loc2_ | 0;
         this._hint.y = _loc1_.y - TutorialHintBuilder.HINT_GLOW_OFFSET + this._hintModel.padding.top * _loc3_ | 0;
         var _loc4_:int = this._hintTarget.width - (this._hintModel.padding.left + this._hintModel.padding.right) * _loc2_ | 0;
         var _loc5_:int = this._hintTarget.height - (this._hintModel.padding.top + this._hintModel.padding.bottom) * _loc3_ | 0;
         this._hint.setSize(_loc4_,_loc5_);
      }
      
      private function onEndAnimation() : void
      {
         this._hintParent.dispatchEvent(new TechTreeEvent(TechTreeEvent.ON_END_HINT_ANIMATION));
      }
      
      private function onHintAnimationEndedHandler(param1:TutorialHintEvent) : void
      {
         var _loc2_:AnimSequenceItem = null;
         this._hint.removeEventListener(TutorialHintEvent.ANIMATION_ENDED,this.onHintAnimationEndedHandler);
         for each(_loc2_ in this._sequence)
         {
            _loc2_.startAnimation();
         }
      }
   }
}

import net.wg.infrastructure.interfaces.entity.IDisposable;
import net.wg.utils.IScheduler;

class AnimSequenceItem implements IDisposable
{
    
   
   private var _animStartFunction:Function = null;
   
   private var _timeout:int;
   
   private var _scheduler:IScheduler = null;
   
   private var _animated:Boolean = false;
   
   function AnimSequenceItem(param1:Function, param2:int)
   {
      super();
      this._scheduler = App.utils.scheduler;
      this._timeout = param2;
      this._animStartFunction = param1;
      this.cancelAnimTask();
   }
   
   public function dispose() : void
   {
      this.cancelAnimTask();
      this._scheduler = null;
      this._animStartFunction = null;
   }
   
   public function startAnimation() : void
   {
      if(!this._animated)
      {
         this._animated = true;
         this._scheduler.scheduleTask(this._animStartFunction,this._timeout);
      }
   }
   
   private function cancelAnimTask() : void
   {
      if(this._scheduler && this._animStartFunction != null)
      {
         this._scheduler.cancelTask(this._animStartFunction);
      }
   }
}
