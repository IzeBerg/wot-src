package net.wg.gui.battle.commander.views.fullStats.list.supply
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.Values;
   import net.wg.gui.battle.commander.VO.daapi.DAAPISupplyInfoVO;
   import net.wg.gui.battle.commander.views.common.VehicleTypeIcon;
   import net.wg.gui.battle.commander.views.fullStats.interfaces.IRTSFullStatsItemSupply;
   import net.wg.gui.battle.commander.views.fullStats.list.base.AbstractRTSFullStatsItem;
   import net.wg.infrastructure.exceptions.AbstractException;
   import net.wg.infrastructure.interfaces.IDAAPIDataClass;
   
   public class AbstractRTSFullStatsItemSupply extends AbstractRTSFullStatsItem implements IRTSFullStatsItemSupply
   {
      
      protected static const INVALID_SUPPLY:uint = FLAGS_BORDER << 1;
      
      protected static const INVALID_COUNT:uint = FLAGS_BORDER << 2;
      
      protected static const INVALID_ALIVE:uint = FLAGS_BORDER << 3;
      
      protected static const ALPHA_ALIVE:Number = 1;
      
      protected static const ALPHA_DEAD:Number = 0.5;
       
      
      public var supplyType:VehicleTypeIcon = null;
      
      public var supplyName:TextField = null;
      
      public var count:TextField = null;
      
      public var frags:TextField = null;
      
      public var deadBg:Sprite = null;
      
      protected var _supplyType:String = "";
      
      protected var _supplyName:String = "";
      
      protected var _aliveCount:Number = 0;
      
      protected var _allCount:Number = 0;
      
      protected var _isAlive:Boolean = true;
      
      public function AbstractRTSFullStatsItemSupply()
      {
         super();
      }
      
      override public function setData(param1:IDAAPIDataClass) : void
      {
         var _loc2_:DAAPISupplyInfoVO = DAAPISupplyInfoVO(param1);
         if(this._supplyType != _loc2_.supplyType || this._supplyName != _loc2_.supplyName)
         {
            this._supplyType = _loc2_.supplyType;
            this._supplyName = _loc2_.supplyName;
            invalidate(INVALID_SUPPLY);
         }
         this.setSupplyCount(_loc2_.alive,_loc2_.all);
         setFrags(_loc2_.frags);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.supplyType.isAlly = this.isAllyItem;
      }
      
      override protected function onDispose() : void
      {
         this.supplyType.dispose();
         this.supplyType = null;
         this.supplyName = null;
         this.count = null;
         this.frags = null;
         this.deadBg = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(INVALID_FRAGS))
         {
            this.frags.text = _frags != 0 ? _frags.toString() : Values.EMPTY_STR;
         }
         if(isInvalid(INVALID_SUPPLY))
         {
            this.supplyType.vehicleType = this._supplyType;
            this.supplyName.text = this._supplyName;
         }
         if(isInvalid(INVALID_COUNT))
         {
            this.count.text = this._aliveCount + " / " + this._allCount;
         }
         if(isInvalid(INVALID_ALIVE))
         {
            this.supplyType.isAlive = this._isAlive;
            this.supplyType.alpha = this.count.alpha = this.supplyName.alpha = !!this._isAlive ? Number(ALPHA_ALIVE) : Number(ALPHA_DEAD);
            this.deadBg.visible = !this._isAlive;
         }
      }
      
      public function setAlive(param1:Boolean) : void
      {
         if(this._isAlive != param1)
         {
            this._isAlive = param1;
            invalidate(INVALID_ALIVE);
         }
      }
      
      public function setSupplyCount(param1:Number, param2:Number) : void
      {
         if(this._aliveCount != param1 || this._allCount != param2)
         {
            this._aliveCount = param1;
            this._allCount = param2;
            this.setAlive(param1 > 0);
            invalidate(INVALID_COUNT);
         }
      }
      
      protected function get isAllyItem() : Boolean
      {
         throw new AbstractException(Errors.ABSTRACT_INVOKE);
      }
   }
}
