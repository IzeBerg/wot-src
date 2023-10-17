package net.wg.gui.lobby.training
{
   import flash.geom.ColorTransform;
   import flash.text.TextField;
   import net.wg.data.VO.TrainingRoomRendererVO;
   import net.wg.data.constants.UserTags;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.components.controls.UserNameField;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.entity.IUpdatable;
   import scaleform.clik.constants.InvalidationType;
   
   public class DragPlayerElementBase extends UIComponentEx implements IUpdatable
   {
      
      private static const GOLD_COLOR:Number = 16761699;
      
      private static const NAME_COLOR:Number = 13224374;
      
      private static const VEHICLE_COLOR:Number = 8092009;
       
      
      public var iconLoader:UILoaderAlt = null;
      
      public var nameField:UserNameField = null;
      
      public var vehicleField:TextField = null;
      
      public var vehicleLevelField:TextField = null;
      
      private var _data:TrainingRoomRendererVO = null;
      
      private var _defColorTrans:ColorTransform = null;
      
      public function DragPlayerElementBase()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._defColorTrans = this.iconLoader.transform.colorTransform;
      }
      
      override protected function onDispose() : void
      {
         this.iconLoader.dispose();
         this.iconLoader = null;
         this.nameField.dispose();
         this.nameField = null;
         this.vehicleField = null;
         this.vehicleLevelField = null;
         this._data = null;
         this._defColorTrans = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         if(isInvalid(InvalidationType.DATA))
         {
            if(this._data)
            {
               this.doUpdateData(this._data);
            }
            else
            {
               this.doResetData();
            }
         }
      }
      
      public function update(param1:Object) : void
      {
         if(param1 && param1 != this._data)
         {
            this._data = TrainingRoomRendererVO(param1);
            invalidate(InvalidationType.DATA);
         }
      }
      
      protected function doResetData() : void
      {
         this.nameField.userVO = null;
         this.vehicleField.text = Values.EMPTY_STR;
         this.vehicleLevelField.text = Values.EMPTY_STR;
         this.iconLoader.visible = false;
         enabled = false;
      }
      
      protected function doUpdateData(param1:TrainingRoomRendererVO) : void
      {
         this.nameField.userVO = param1;
         this.vehicleField.htmlText = param1.vShortName;
         this.vehicleLevelField.text = param1.vLevel;
         this.iconLoader.visible = true;
         if(this.iconLoader.source != param1.icon)
         {
            this.iconLoader.source = param1.icon;
         }
         enabled = true;
         this.nameField.textColor = NAME_COLOR;
         this.vehicleField.textColor = VEHICLE_COLOR;
         var _loc2_:ColorTransform = new ColorTransform();
         if(!enabled)
         {
            _loc2_.alphaMultiplier = 0.7;
            _loc2_.redMultiplier = 0.1;
            _loc2_.blueMultiplier = 0.1;
            _loc2_.greenMultiplier = 0.1;
         }
         else if(UserTags.isCurrentPlayer(param1.tags))
         {
            this.nameField.textColor = GOLD_COLOR;
            this.vehicleField.textColor = GOLD_COLOR;
            _loc2_.redOffset = 21;
            _loc2_.greenOffset = 9;
            _loc2_.blueMultiplier = 0.51;
            _loc2_.greenMultiplier = 0.87;
         }
         else
         {
            _loc2_ = this._defColorTrans;
         }
         this.iconLoader.transform.colorTransform = _loc2_;
      }
   }
}
