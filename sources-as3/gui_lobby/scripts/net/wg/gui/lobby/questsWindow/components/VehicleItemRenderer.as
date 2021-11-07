package net.wg.gui.lobby.questsWindow.components
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.VO.ProgressElementVO;
   import net.wg.data.constants.QuestsStates;
   import net.wg.gui.components.controls.BitmapFill;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.lobby.components.ProgressIndicator;
   import net.wg.gui.lobby.questsWindow.data.QuestVehicleRendererVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.controls.ListItemRenderer;
   import scaleform.clik.events.ComponentEvent;
   
   public class VehicleItemRenderer extends ListItemRenderer
   {
      
      private static const SEPARATOR_PADDING:int = 2;
       
      
      public var nationIcon:UILoaderAlt;
      
      public var typeIcon:UILoaderAlt;
      
      public var levelMC:MovieClip;
      
      public var tankSmallIcon:UILoaderAlt;
      
      public var vehTF:TextField;
      
      public var htmlTF:TextField;
      
      public var progress:ProgressIndicator;
      
      public var naMC:MovieClip;
      
      public var disableMc:BitmapFill;
      
      public var disableOverlayMc:BitmapFill;
      
      public var noVehicle:TextField;
      
      private var nations:Array;
      
      private var isDisabled:Boolean = false;
      
      public var statusMC:QuestStatusComponent;
      
      public function VehicleItemRenderer()
      {
         this.nations = [];
         super();
         this.levelMC.visible = false;
         this.nations = App.utils.getNationNamesS();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.nationIcon.hideLoader = false;
         this.typeIcon.hideLoader = false;
         this.tankSmallIcon.hideLoader = false;
         preventAutosizing = true;
         this.updateDisable(this.disableMc);
         this.updateDisable(this.disableOverlayMc);
         constraints = null;
         this.statusMC.setStatus(QuestsStates.DONE);
         this.statusMC.textAlign = TextFieldAutoSize.RIGHT;
         this.statusMC.showTooltip = false;
         this.statusMC.validateNow();
         this.statusMC.visible = false;
         this.setNoData();
         this.noVehicle.text = QUESTS.QUESTS_TABLE_NOVEHICLES;
      }
      
      override public function setData(param1:Object) : void
      {
         this.data = param1;
         invalidateData();
      }
      
      override protected function draw() : void
      {
         var _loc1_:QuestVehicleRendererVO = null;
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:ProgressElementVO = null;
         if(isInvalid(InvalidationType.STATE))
         {
            if(_newFrame)
            {
               gotoAndPlay(_newFrame);
               if(_baseDisposed)
               {
                  return;
               }
               _newFrame = null;
            }
            if(focusIndicator && _newFocusIndicatorFrame)
            {
               focusIndicator.gotoAndPlay(_newFocusIndicatorFrame);
               _newFocusIndicatorFrame = null;
            }
            updateAfterStateChange();
            dispatchEvent(new ComponentEvent(ComponentEvent.STATE_CHANGE));
            invalidate(InvalidationType.DATA,InvalidationType.SIZE);
         }
         if(isInvalid(InvalidationType.DATA))
         {
            if(data)
            {
               _loc1_ = QuestVehicleRendererVO(data);
               this.resetVisible();
               _loc2_ = this.getNationIconPath(_loc1_.nationID);
               _loc3_ = this.getTypeIconPath(_loc1_.vType);
               if(this.nationIcon.source != _loc2_)
               {
                  this.nationIcon.source = _loc2_;
               }
               if(this.typeIcon.source != _loc3_)
               {
                  this.typeIcon.source = _loc3_;
               }
               if(this.tankSmallIcon.source != _loc1_.vIconSmall)
               {
                  this.tankSmallIcon.source = _loc1_.vIconSmall;
               }
               this.vehTF.htmlText = _loc1_.vName;
               this.htmlTF.htmlText = _loc1_.htmlLabel;
               this.htmlTF.visible = !_loc1_.showDone;
               this.levelMC.gotoAndStop(_loc1_.vLevel);
               this.progress.visible = Boolean(_loc1_.progressData && !_loc1_.showDone);
               this.naMC.visible = !_loc1_.isAvailable && !_loc1_.showDone;
               this.statusMC.visible = _loc1_.showDone;
               this.isDisabled = _loc1_.isDisabled;
               if(_loc1_.progressData)
               {
                  _loc4_ = ProgressElementVO(_loc1_.progressData);
                  this.progress.setValues(_loc4_.progrBarType,_loc4_.currentProgrVal,_loc4_.maxProgrVal);
                  this.progress.setTooltip(_loc4_.progrTooltip);
               }
            }
            else
            {
               this.setNoData();
            }
            this.updateDisable(this.disableMc);
            this.updateDisable(this.disableOverlayMc);
         }
      }
      
      private function setNoData() : void
      {
         this.nationIcon.visible = false;
         this.typeIcon.visible = false;
         this.levelMC.visible = false;
         this.tankSmallIcon.visible = false;
         this.vehTF.visible = false;
         this.htmlTF.visible = false;
         this.progress.visible = false;
         this.naMC.visible = false;
         this.noVehicle.visible = true;
         this.statusMC.visible = false;
         this.isDisabled = false;
      }
      
      private function resetVisible() : void
      {
         this.nationIcon.visible = true;
         this.typeIcon.visible = true;
         this.levelMC.visible = true;
         this.tankSmallIcon.visible = true;
         this.vehTF.visible = true;
         this.htmlTF.visible = true;
         this.noVehicle.visible = false;
         this.levelMC.visible = true;
      }
      
      public function getNationIconPath(param1:int) : String
      {
         return "../maps/icons/filters/nations/" + this.nations[param1] + ".png";
      }
      
      public function getTypeIconPath(param1:String) : String
      {
         return "../maps/icons/filters/tanks/" + param1 + ".png";
      }
      
      override protected function onDispose() : void
      {
         this.noVehicle = null;
         this.htmlTF = null;
         this.levelMC = null;
         this.naMC = null;
         this.vehTF = null;
         if(this.progress)
         {
            this.progress.dispose();
            this.progress = null;
         }
         if(this.disableMc)
         {
            this.disableMc.dispose();
            this.disableMc = null;
         }
         if(this.disableOverlayMc)
         {
            this.disableOverlayMc.dispose();
            this.disableOverlayMc = null;
         }
         if(this.statusMC)
         {
            this.statusMC.dispose();
            this.statusMC = null;
         }
         if(this.nationIcon)
         {
            this.nationIcon.dispose();
            this.nationIcon = null;
         }
         if(this.typeIcon)
         {
            this.typeIcon.dispose();
            this.typeIcon = null;
         }
         if(this.tankSmallIcon)
         {
            this.tankSmallIcon.dispose();
            this.tankSmallIcon = null;
         }
         if(this.nations)
         {
            this.nations.splice(0,this.nations.length);
            this.nations = null;
         }
         if(data)
         {
            if(data is IDisposable)
            {
               IDisposable(data).dispose();
            }
            data = null;
         }
         super.onDispose();
      }
      
      protected function updateDisable(param1:BitmapFill) : void
      {
         var _loc2_:Number = NaN;
         if(param1 != null)
         {
            param1.visible = this.isDisabled;
            _loc2_ = Math.max(this.scaleX,this.scaleY);
            param1.scaleX = 1 / _loc2_;
            param1.scaleY = 1 / _loc2_;
            param1.widthFill = Math.round(this.width * _loc2_);
            param1.heightFill = Math.round(this.height * _loc2_) - SEPARATOR_PADDING;
         }
      }
   }
}
