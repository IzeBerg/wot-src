package net.wg.gui.battle.tutorial.views.tutorial.components.taskPanel
{
   import fl.transitions.easing.Regular;
   import flash.display.Sprite;
   import net.wg.data.constants.Values;
   import net.wg.gui.battle.tutorial.views.tutorial.components.taskPanel.containers.Header;
   import net.wg.gui.battle.tutorial.views.tutorial.components.taskPanel.containers.Hint;
   import net.wg.gui.battle.tutorial.views.tutorial.components.taskPanel.containers.Icon;
   import net.wg.gui.battle.tutorial.views.tutorial.components.taskPanel.containers.Task;
   import net.wg.gui.battle.tutorial.views.tutorial.interfaces.IBattleTutorialDoneAnim;
   import net.wg.gui.battle.tutorial.views.tutorial.interfaces.IBattleTutorialTasksPanel;
   import net.wg.gui.battle.tutorial.views.tutorial.utils.tween.TutorialTweener;
   
   public class BattleTutorialTasksPanel extends Sprite implements IBattleTutorialTasksPanel
   {
      
      private static const ANIM_STATUS_HIDING:String = "hiding";
      
      private static const ANIM_STATUS_SHOWING:String = "showing";
      
      private static const ANIM_STATUS_HIDE:String = "hide";
      
      private static const ANIM_STATUS_SET:String = "set";
      
      private static const ANIM_STATUS_NONE:String = "none";
      
      private static const FLAG_DONE:String = "done";
      
      private static const FLAG_IN_PROGRESS:String = "in_progress";
      
      private static const FLAG_NO_STATUS:String = "none";
      
      private static const CHAPTER_POSITION_Y:int = 12;
      
      private static const HINT_POSITION_Y:int = 12;
      
      private static const TASK_POSITION_Y:int = 51;
      
      private static const OFFSET_Y:int = 6;
      
      private static const OFFSET_HINT_Y:int = 10;
      
      private static const ICON_OFFSET_Y:int = 17;
      
      private static const ANIMATION_TIME:int = 500;
      
      private static const BG_SCALE_COEF:int = 300;
      
      private static const HEADER_TWEEN_SHOW_ID:int = 1;
      
      private static const HEADER_TWEEN_HIDE_ID:int = 2;
      
      private static const TASK_TWEEN_SHOW_ID:int = 3;
      
      private static const TASK_TWEEN_HIDE_ID:int = 4;
      
      private static const ICON_TWEEN_SHOW_ID:int = 5;
      
      private static const ICON_TWEEN_HIDE_ID:int = 6;
      
      private static const HINT_TWEEN_SHOW_ID:int = 7;
      
      private static const HINT_TWEEN_HIDE_ID:int = 8;
      
      private static const PICTURE_TWEEN_SHOW_ID:int = 9;
      
      private static const PICTURE_TWEEN_HIDE_ID:int = 10;
      
      private static const BG_TWEEN_ID:int = 11;
       
      
      public var headerSpr:Header = null;
      
      public var taskMc:Task = null;
      
      public var iconSpr:Icon = null;
      
      public var hintSpr:Hint = null;
      
      public var bgSpr:Sprite = null;
      
      private var _doneAnim:IBattleTutorialDoneAnim = null;
      
      private var _headerStr:String = "";
      
      private var _headerStrCurrent:String = "";
      
      private var _isNeedChangeHeader:Boolean = false;
      
      private var _taskStr:String = "";
      
      private var _taskStrCurrent:String = "";
      
      private var _taskStatus:String = "none";
      
      private var _taskFlag:String = "none";
      
      private var _taskFlagStatus:String = "none";
      
      private var _isFlagIsChangedAlphaOnly:Boolean = false;
      
      private var _isNeedChangeTask:Boolean = false;
      
      private var _taskId:String = "";
      
      private var _taskIdCurent:String = "";
      
      private var _hintStatus:String = "none";
      
      private var _hintStr:String = "";
      
      private var _img:String = "";
      
      private var _altImg:String = "";
      
      private var _isNeedChangeHint:Boolean = false;
      
      private var _hintId:String = "";
      
      private var _hintStrCurrent:String = "";
      
      private var _hintIdCurrent:String = "";
      
      private var _taskPositionY:int = 51;
      
      private var _hintPositionY:int = 81;
      
      private var _headerTweener:TutorialTweener = null;
      
      private var _hintTweener:TutorialTweener = null;
      
      private var _taskTweener:TutorialTweener = null;
      
      private var _iconTweener:TutorialTweener = null;
      
      private var _pictureTweener:TutorialTweener = null;
      
      private var _bgTweener:TutorialTweener = null;
      
      public function BattleTutorialTasksPanel()
      {
         super();
         this.reset();
         this._headerTweener = new TutorialTweener(true);
         this._taskTweener = new TutorialTweener(true);
         this._iconTweener = new TutorialTweener(true);
         this._hintTweener = new TutorialTweener(true);
         this._pictureTweener = new TutorialTweener(true);
         this._bgTweener = new TutorialTweener(true);
      }
      
      private function reset() : void
      {
         this.headerSpr.alpha = 0;
         this.taskMc.alpha = 0;
         this.iconSpr.alpha = 0;
         this.hintSpr.alpha = 0;
         this._taskPositionY = TASK_POSITION_Y;
         this._hintPositionY = HINT_POSITION_Y;
         this.headerSpr.y = CHAPTER_POSITION_Y + OFFSET_Y;
      }
      
      public function setChapter(param1:String) : void
      {
         if(this._headerStr != param1)
         {
            this._headerStr = param1;
            if(this._taskFlag == FLAG_NO_STATUS)
            {
               this.setChapterData();
               this.showChapter();
            }
            else
            {
               this._isNeedChangeHeader = true;
            }
         }
      }
      
      private function setChapterData() : void
      {
         this.headerSpr.y = CHAPTER_POSITION_Y + OFFSET_Y;
         this.headerSpr.setHeaderText(this._headerStr);
         this._headerStrCurrent = this._headerStr;
         this._taskPositionY = CHAPTER_POSITION_Y + this.headerSpr.getHeaderTextHeight() + OFFSET_Y;
         this._hintPositionY = this._taskPositionY + this.taskMc.getTaskTextHeight() + OFFSET_HINT_Y;
      }
      
      private function showChapter() : void
      {
         this._headerTweener.tween(this.headerSpr,ANIMATION_TIME,{
            "y":CHAPTER_POSITION_Y,
            "alpha":1,
            "ease":Regular.easeOut
         },this,HEADER_TWEEN_SHOW_ID);
      }
      
      private function hideChapter() : void
      {
         this._headerTweener.tween(this.headerSpr,ANIMATION_TIME,{
            "y":CHAPTER_POSITION_Y - OFFSET_Y,
            "alpha":0,
            "ease":Regular.easeIn
         },this,HEADER_TWEEN_HIDE_ID);
      }
      
      private function headerShowTweenComplete() : void
      {
         if(this._headerStr != this._headerStrCurrent)
         {
            this.hideChapter();
         }
      }
      
      private function headerHideTweenComplete() : void
      {
         this.setChapterData();
         this.showChapter();
      }
      
      public function setTask(param1:String, param2:Object, param3:String) : void
      {
         var _loc4_:String = this.getTaskFlag(param2);
         if(this._taskStr != param1 || this._taskId != param3)
         {
            this._taskStr = param1;
            this._taskId = param3;
            this._isNeedChangeTask = true;
            if(_loc4_ != this._taskFlag)
            {
               this._isFlagIsChangedAlphaOnly = true;
            }
         }
         if(_loc4_ != this._taskFlag)
         {
            this._taskFlag = _loc4_;
            if(this._taskStatus != ANIM_STATUS_HIDING)
            {
               if(this._taskFlagStatus == ANIM_STATUS_SET)
               {
                  this.changeFlag();
               }
               else if(this._taskFlagStatus == ANIM_STATUS_NONE)
               {
                  this._taskFlag = FLAG_IN_PROGRESS;
                  this._isFlagIsChangedAlphaOnly = false;
                  this._isNeedChangeTask = false;
                  this.setFlagData();
                  this.showFlag();
                  this.startAnimTask();
               }
            }
            else
            {
               this._taskFlag = FLAG_IN_PROGRESS;
               this._isNeedChangeTask = false;
            }
         }
         else if(this._isNeedChangeTask)
         {
            if(this._taskFlag == FLAG_DONE && this._taskFlagStatus == ANIM_STATUS_SHOWING)
            {
               this.changeFlag();
            }
            else
            {
               this._isNeedChangeTask = false;
               this.startAnimTask();
            }
         }
      }
      
      private function startAnimTask() : void
      {
         if(this._taskStatus == ANIM_STATUS_SET)
         {
            this.hideTask();
         }
         else if(this._taskStatus == ANIM_STATUS_NONE)
         {
            this.setTaskData();
            this.showTask();
         }
      }
      
      private function setTaskData() : void
      {
         this.taskMc.setTaskText(this._taskStr);
         this._taskStrCurrent = this._taskStr;
         this._taskIdCurent = this._taskId;
         this.taskMc.y = this._taskPositionY + OFFSET_Y;
         if(this._hintPositionY != this._taskPositionY + this.taskMc.getTaskTextHeight() + OFFSET_HINT_Y)
         {
            this._hintPositionY = this._taskPositionY + this.taskMc.getTaskTextHeight() + OFFSET_HINT_Y;
            if(this._hintStr)
            {
               this.changeHintPos();
               this.rescaleBg();
               this._hintStatus = ANIM_STATUS_SHOWING;
            }
         }
      }
      
      private function showTask() : void
      {
         this._taskTweener.tween(this.taskMc,ANIMATION_TIME,{
            "y":this._taskPositionY,
            "alpha":1,
            "ease":Regular.easeOut
         },this,TASK_TWEEN_SHOW_ID);
         this._taskStatus = ANIM_STATUS_SHOWING;
      }
      
      private function hideTask() : void
      {
         this._isNeedChangeTask = false;
         this.changeFlag();
         this._taskTweener.tween(this.taskMc,ANIMATION_TIME,{
            "y":this._taskPositionY - OFFSET_Y,
            "alpha":0,
            "ease":Regular.easeIn
         },this,TASK_TWEEN_HIDE_ID);
         this._taskStatus = ANIM_STATUS_HIDING;
      }
      
      public function finishedAnimTaskDone() : void
      {
         this._taskFlagStatus = ANIM_STATUS_HIDE;
         this.taskMc.animate();
         this.setFlagData();
         this.showFlag();
      }
      
      private function taskMcShowTweenComplete() : void
      {
         this._taskStatus = ANIM_STATUS_SET;
      }
      
      private function taskMcHideTweenComplete() : void
      {
         this._taskStatus = ANIM_STATUS_HIDE;
         this.setTaskData();
         this.showTask();
      }
      
      private function changeFlag() : void
      {
         if(this._taskFlag == FLAG_DONE)
         {
            this.startFXAnim();
            this._taskFlagStatus = ANIM_STATUS_HIDING;
         }
         else
         {
            this.hideFlag();
         }
      }
      
      private function showFlag() : void
      {
         this._iconTweener.tween(this.iconSpr,ANIMATION_TIME,{
            "y":this._taskPositionY + ICON_OFFSET_Y,
            "alpha":1,
            "ease":Regular.easeOut
         },this,ICON_TWEEN_SHOW_ID);
         this._taskFlagStatus = ANIM_STATUS_SHOWING;
      }
      
      private function hideFlag() : void
      {
         if(this._isFlagIsChangedAlphaOnly)
         {
            this._iconTweener.tween(this.iconSpr,ANIMATION_TIME,{
               "alpha":0,
               "ease":Regular.easeIn
            },this,ICON_TWEEN_HIDE_ID);
         }
         else
         {
            this._iconTweener.tween(this.iconSpr,ANIMATION_TIME,{
               "y":this._taskPositionY - OFFSET_Y + ICON_OFFSET_Y,
               "alpha":0,
               "ease":Regular.easeIn
            },this,ICON_TWEEN_HIDE_ID);
         }
         this._taskFlagStatus = ANIM_STATUS_HIDING;
      }
      
      private function setFlagData() : void
      {
         if(!this._isFlagIsChangedAlphaOnly || this._taskStatus == ANIM_STATUS_SHOWING)
         {
            this._isFlagIsChangedAlphaOnly = false;
            this.iconSpr.y = this._taskPositionY + OFFSET_Y + ICON_OFFSET_Y;
         }
         this.iconSpr.setDoneIconVisible(false);
         this.iconSpr.setInProgressIconVisible(false);
         if(this._taskFlag == FLAG_DONE)
         {
            this.iconSpr.setDoneIconVisible(true);
            this.iconSpr.showDoneIconAnimate();
         }
         else if(this._taskFlag == FLAG_IN_PROGRESS)
         {
            this.iconSpr.setInProgressIconVisible(true);
         }
      }
      
      private function getTaskFlag(param1:Object) : String
      {
         if(param1 == null)
         {
            return FLAG_IN_PROGRESS;
         }
         if(param1 == true)
         {
            return FLAG_DONE;
         }
         return FLAG_NO_STATUS;
      }
      
      private function iconShowTweenComplete() : void
      {
         this._isFlagIsChangedAlphaOnly = false;
         this._taskFlagStatus = ANIM_STATUS_SET;
         if(this._isNeedChangeHeader || this._headerStr != this._headerStrCurrent)
         {
            this._isNeedChangeHeader = false;
            this.hideChapter();
         }
         if(this._isNeedChangeTask || this._taskStrCurrent != this._taskStr || this._taskIdCurent != this._taskId)
         {
            this._isNeedChangeTask = false;
            this._taskFlag = FLAG_IN_PROGRESS;
            this.startAnimTask();
         }
         if(this._isNeedChangeHint || this._hintStrCurrent != this._hintStr || this._hintIdCurrent != this._hintId)
         {
            if(this._hintStatus != ANIM_STATUS_HIDING)
            {
               this._isNeedChangeHint = false;
               this.hideHint();
            }
         }
      }
      
      private function iconHideTweenComplete() : void
      {
         this._taskFlagStatus = ANIM_STATUS_HIDE;
         this.setFlagData();
         this.showFlag();
      }
      
      public function setHint(param1:String, param2:String, param3:String, param4:String) : void
      {
         if(this._hintStr != param1 || this._hintId != param4)
         {
            this._hintStr = param1;
            this._hintId = param4;
            this._img = param2;
            this._altImg = param3;
            if((this._taskFlagStatus == ANIM_STATUS_HIDING || this._taskFlagStatus == ANIM_STATUS_HIDE) && this._isFlagIsChangedAlphaOnly)
            {
               this._isNeedChangeHint = true;
               return;
            }
            if(this._hintStatus == ANIM_STATUS_SET && this._hintStatus != ANIM_STATUS_HIDING)
            {
               this.hideHint();
            }
            else if(this._hintStatus == ANIM_STATUS_NONE)
            {
               this.setHintData();
               this.showHint();
            }
         }
         else if(this._img != param2 || this._altImg != param3)
         {
            this.hide_picture();
         }
      }
      
      private function setHintData() : void
      {
         this.hintSpr.y = this._hintPositionY + OFFSET_Y;
         this.hintSpr.setHintText(this._hintStr);
         this._hintStrCurrent = this._hintStr;
         this._hintIdCurrent = this._hintId;
         this.set_pictureData();
         this.rescaleBg();
      }
      
      private function showHint() : void
      {
         this._hintTweener.tween(this.hintSpr,ANIMATION_TIME,{
            "y":this._hintPositionY,
            "alpha":1,
            "ease":Regular.easeOut
         },this,HINT_TWEEN_SHOW_ID);
         this._hintStatus = ANIM_STATUS_SHOWING;
      }
      
      private function hideHint() : void
      {
         this._hintTweener.tween(this.hintSpr,ANIMATION_TIME,{
            "y":this._hintPositionY - OFFSET_Y,
            "alpha":0,
            "ease":Regular.easeIn
         },this,HINT_TWEEN_HIDE_ID);
         this._hintStatus = ANIM_STATUS_HIDING;
      }
      
      private function changeHintPos() : void
      {
         if(this._hintStatus != ANIM_STATUS_HIDING)
         {
            this._hintTweener.tween(this.hintSpr,ANIMATION_TIME,{
               "y":this._hintPositionY,
               "alpha":1,
               "ease":Regular.easeOut
            },this,HINT_TWEEN_SHOW_ID);
         }
      }
      
      private function hintShowTweenComplete() : void
      {
         this._hintStatus = ANIM_STATUS_SET;
         if(this._hintStr != this._hintStrCurrent)
         {
            this.hideHint();
         }
      }
      
      private function hintHideTweenComplete() : void
      {
         this._hintStatus = ANIM_STATUS_HIDE;
         this._isNeedChangeHint = false;
         this.setHintData();
         this.showHint();
      }
      
      private function show_picture() : void
      {
         this._pictureTweener.tween(this.hintSpr.picture,ANIMATION_TIME,{
            "alpha":1,
            "ease":Regular.easeOut
         },this,PICTURE_TWEEN_SHOW_ID);
      }
      
      private function hide_picture() : void
      {
         this._pictureTweener.tween(this.hintSpr.picture,ANIMATION_TIME,{
            "alpha":0,
            "ease":Regular.easeIn
         },this,PICTURE_TWEEN_HIDE_ID);
      }
      
      private function set_pictureData() : void
      {
         this.hintSpr.unloadPicture();
         if(this._img == Values.EMPTY_STR)
         {
            this.hintSpr.setPictureVisible(false);
         }
         else if(this._img != this.hintSpr.getPictureSource() || this._altImg != this.hintSpr.getPictureSourceAlt())
         {
            this.hintSpr.setPictureVisible(true);
            this.hintSpr.setPictureSourceAlt(this._altImg);
            this.hintSpr.setPictureSource(this._img);
         }
         this.hintSpr.autoPositionPicture();
      }
      
      private function _pictureHideTweenComplete() : void
      {
         this.set_pictureData();
         this.show_picture();
      }
      
      private function rescaleBg() : void
      {
         var _loc1_:Number = (this.taskMc.getTaskTextHeight() + this.hintSpr.getHintTextHeight()) / BG_SCALE_COEF;
         var _loc2_:int = this.taskMc.y + (this.hintSpr.y + this.hintSpr.getHintTextHeight() - this.taskMc.y >> 1);
         this._bgTweener.tween(this.bgSpr,ANIMATION_TIME,{
            "y":_loc2_,
            "scaleY":_loc1_,
            "ease":Regular.easeOut
         },this,BG_TWEEN_ID);
      }
      
      private function startFXAnim() : void
      {
         if(this._doneAnim)
         {
            this._doneAnim.startAnimTaskDone();
         }
      }
      
      public function onTweenComplete(param1:int) : void
      {
         switch(param1)
         {
            case HEADER_TWEEN_SHOW_ID:
               this.headerShowTweenComplete();
               break;
            case HEADER_TWEEN_HIDE_ID:
               this.headerHideTweenComplete();
               break;
            case TASK_TWEEN_SHOW_ID:
               this.taskMcShowTweenComplete();
               break;
            case TASK_TWEEN_HIDE_ID:
               this.taskMcHideTweenComplete();
               break;
            case ICON_TWEEN_SHOW_ID:
               this.iconShowTweenComplete();
               break;
            case ICON_TWEEN_HIDE_ID:
               this.iconHideTweenComplete();
               break;
            case HINT_TWEEN_SHOW_ID:
               this.hintShowTweenComplete();
               break;
            case HINT_TWEEN_HIDE_ID:
               this.hintHideTweenComplete();
               break;
            case PICTURE_TWEEN_HIDE_ID:
               this._pictureHideTweenComplete();
         }
      }
      
      public function getIconY() : int
      {
         return this.iconSpr.y - ICON_OFFSET_Y;
      }
      
      public function set doneAnim(param1:IBattleTutorialDoneAnim) : void
      {
         this._doneAnim = param1;
      }
      
      public function dispose() : void
      {
         this.headerSpr.dispose();
         this.taskMc.dispose();
         this.iconSpr.dispose();
         this.hintSpr.dispose();
         this.headerSpr = null;
         this.taskMc = null;
         this.iconSpr = null;
         this.hintSpr = null;
         this.bgSpr = null;
         this._doneAnim = null;
         this._headerTweener.dispose();
         this._hintTweener.dispose();
         this._taskTweener.dispose();
         this._iconTweener.dispose();
         this._pictureTweener.dispose();
         this._bgTweener.dispose();
         this._headerTweener = null;
         this._hintTweener = null;
         this._taskTweener = null;
         this._iconTweener = null;
         this._pictureTweener = null;
         this._bgTweener = null;
      }
   }
}
