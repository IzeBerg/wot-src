package net.wg.gui.lobby.comp7.battleResults.components
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.TextField;
   import net.wg.data.constants.ProgressIndicatorStates;
   import net.wg.gui.lobby.battleResults.data.Comp7SubTaskVO;
   import net.wg.gui.lobby.components.ProgressIndicator;
   import net.wg.gui.lobby.interfaces.ISubtaskComponent;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.IImage;
   import net.wg.utils.ICommons;
   import scaleform.clik.constants.InvalidationType;
   
   public class Comp7SubTask extends UIComponentEx implements ISubtaskComponent
   {
      
      private static const RATING_DIFF_PROGRESS_BAR_X_SHIFT:int = -2;
       
      
      public var title:TextField = null;
      
      public var descr:TextField = null;
      
      public var icon:IImage = null;
      
      public var ratingDiff:TextField = null;
      
      public var progressIndicator:ProgressIndicator = null;
      
      public var ratingTotal:TextField = null;
      
      public var lineMC:MovieClip = null;
      
      private var _data:Comp7SubTaskVO = null;
      
      private var _hasProgressBar:Boolean = false;
      
      private var _commons:ICommons = null;
      
      public function Comp7SubTask()
      {
         super();
         this._commons = App.utils.commons;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.icon.addEventListener(Event.CHANGE,this.onIconChangeHandler);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data)
         {
            if(isInvalid(InvalidationType.DATA))
            {
               this._hasProgressBar = this._data.hasProgressBar;
               this.title.htmlText = this._data.title;
               this.descr.htmlText = this._data.descr;
               this.icon.source = this._data.icon;
               this.ratingDiff.htmlText = this._data.ratingDiff;
               this.progressIndicator.visible = this._hasProgressBar;
               this.ratingTotal.visible = !this._hasProgressBar;
               if(this._hasProgressBar)
               {
                  this.progressIndicator.setValues(ProgressIndicatorStates.CURRENT,this._data.progressBarCurrent,this._data.progressBarTotal,this._data.progressBarBegin);
               }
               else
               {
                  this.ratingTotal.htmlText = this._data.ratingTotal;
               }
            }
            if(isInvalid(InvalidationType.LAYOUT))
            {
               this._commons.updateTextFieldSize(this.ratingDiff,true,false);
               if(this._hasProgressBar)
               {
                  this.ratingDiff.x = this.progressIndicator.x - this.ratingDiff.width + RATING_DIFF_PROGRESS_BAR_X_SHIFT | 0;
               }
               else
               {
                  this.ratingDiff.x = (this.icon.width - this.ratingDiff.width >> 1) + this.icon.x | 0;
                  this._commons.updateTextFieldSize(this.ratingTotal,true,false);
                  this.ratingTotal.x = (this.icon.width - this.ratingTotal.width >> 1) + this.icon.x | 0;
               }
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.icon.removeEventListener(Event.CHANGE,this.onIconChangeHandler);
         this.icon.dispose();
         this.icon = null;
         this.progressIndicator.dispose();
         this.progressIndicator = null;
         this.title = null;
         this.descr = null;
         this.ratingDiff = null;
         this.ratingTotal = null;
         this.lineMC = null;
         this._data = null;
         this._commons = null;
         super.onDispose();
      }
      
      public function disableLinkBtns(param1:Vector.<String>) : void
      {
      }
      
      public function setData(param1:Object) : void
      {
         this._data = Comp7SubTaskVO(param1);
         invalidateData();
      }
      
      override public function get height() : Number
      {
         return this.lineMC.y;
      }
      
      private function onIconChangeHandler(param1:Event) : void
      {
         invalidateLayout();
      }
   }
}
