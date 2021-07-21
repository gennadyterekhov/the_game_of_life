class GameField extends React.Component {
    constructor(props) {
        super(props);

        const initialState = this.getInitialState();
        this.state = {
            startBtnPressed: false,
            aliveStr: '■  ',
            deadStr: '□  ',
            prePreviousState: JSON.parse(JSON.stringify(initialState)),
            points: initialState,
            finished: false,
            iteration: 0,
        };
        
        this.getPointStr = this.getPointStr.bind(this);
        this.getPointsStr = this.getPointsStr.bind(this);
        this.getInitialState = this.getInitialState.bind(this);

        this.getMutatedPoints = this.getMutatedPoints.bind(this);
        this.getMutatedPoint = this.getMutatedPoint.bind(this);
        this.countAliveNeighbours = this.countAliveNeighbours.bind(this);
        this.getNeighboursCoordinates = this.getNeighboursCoordinates.bind(this);
        this.mutatePoints = this.mutatePoints.bind(this);
    }

    componentWillUnmount() {

    }

    getInitialState() {
        let points = [];
        for (let i = 0; i < this.props.height; i += 1) {
            points.push(new Array());
            for (let j = 0; j < this.props.width; j += 1) {
                points[i].push(Math.floor(Math.random() * 2));
            }
        }
        return points;
    }

    getPointStr(value) {
        return (value === 1) ? this.state.aliveStr: this.state.deadStr;
    }

    getPointsStr() {
        let str = '';
        for (let i = 0; i < this.props.height; i += 1) {
            for (let j = 0; j < this.props.width; j += 1) {
                str += this.getPointStr(this.state.points[i][j]);
            }
            str += '\n';
        }
        return str;
    }

    getMutatedPoints() {
        let newPoints = JSON.parse(JSON.stringify(this.state.points));
        let mutatedPointsCount = 0;
        for (let y = 0; y < this.props.height; y += 1) {
            for (let x = 0; x < this.props.width; x += 1) {
                newPoints[y][x] = this.getMutatedPoint(x, y);
                mutatedPointsCount += (this.state.points[y][x] !== newPoints[y][x]) ? 1 : 0;
            }
        }
        if (mutatedPointsCount === 0) {
            this.setState({
                finished: true
            });
            console.log('Game field reached stasis or entered loop');
        }
        return newPoints;
    }

    getMutatedPoint(x, y) {
        const aliveCount = this.countAliveNeighbours(x, y);
        const alive = (this.state.points[y][x] === 1) ? true : false;
        return ((alive && (aliveCount === 2)) || (aliveCount === 3)) ? 1 : 0;
    }

    countAliveNeighbours(x, y) {
        let aliveCount = 0;
        const neighboursCoordinates = this.getNeighboursCoordinates(x, y);
        for (let i = 0; i < neighboursCoordinates.length; i += 1) {
            aliveCount += this.state.points[neighboursCoordinates[i][1]][neighboursCoordinates[i][0]];
        }
        return aliveCount;
    }

    getNeighboursCoordinates(targetX, targetY) {
        return [
            [targetX - 1, targetY],
            [targetX + 1, targetY],
            [targetX, targetY - 1],
            [targetX, targetY + 1],
            [targetX - 1, targetY - 1],
            [targetX - 1, targetY + 1],
            [targetX + 1, targetY - 1],
            [targetX + 1, targetY + 1]
        ].filter((value) => {
            const x = value[0];
            const y = value[1];
            const xOk = ((x >= 0) && (x < this.props.width));
            const yOk = ((y >= 0) && (y < this.props.height));
            return (xOk && yOk);
        });
    }

    mutatePoints() {
        const mutatedPoints = this.getMutatedPoints();
        this.setState({
            points: mutatedPoints,
            iteration: this.state.iteration + 1
        });
    }

    render() {
        if (!this.state.finished) {
            setTimeout(() => {
                this.mutatePoints();
                
            }, this.props.timeout);
        }

        const pointsStr = this.getPointsStr();

        return (
            <div>
                <br />
                <br />
                <div>
                    Iteration № {this.state.iteration}
                </div>
                
                <br />
                {this.state.finished &&
                <div>
                    Game field reached stasis or entered loop
                </div>
                }
                <br />
                <pre style={{ fontSize: this.props.fontSize }}>
                    { pointsStr }
                </pre>
               
            </div>
        );
    }
}


class App extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            startBtnPressed: false,
            width: 20,
            height: 20,
            fontSize: 20,
            timeout: 300
        };
        this.startBtnOnClick = this.startBtnOnClick.bind(this);
        this.stopBtnOnClick = this.stopBtnOnClick.bind(this);
        this.onWidthChange = this.onWidthChange.bind(this);
        this.onHeightChange = this.onHeightChange.bind(this);
        this.onTimeoutChange = this.onTimeoutChange.bind(this);
        this.onFontSizeChange = this.onFontSizeChange.bind(this);
        
        
    }

    startBtnOnClick(event) {
        console.log('start pressed');
        this.setState({
            startBtnPressed: true
        });
    }

    stopBtnOnClick(event) {
        console.log('stop pressed');
        this.setState({
            startBtnPressed: false
        });
    }

    onWidthChange(event) {
        this.setState({
            width: event.target.value
        })
    }

    onHeightChange(event) {
        this.setState({
            height: event.target.value
        })
    }

    onTimeoutChange(event) {
        this.setState({
            timeout: event.target.value
        })
    }

    onFontSizeChange(event) {
        this.setState({
            fontSize: event.target.value
        })
    }

    render() {
        return (
            <div>
                <br></br>
                <br></br>
                {this.state.startBtnPressed &&
                <div className="container text-center">
                    <button className="btn btn-primary btn-lg" onClick={this.stopBtnOnClick}>Back</button>
                    <GameField fontSize={this.state.fontSize} height={this.state.height} width={this.state.width} timeout={this.state.timeout}></GameField>
                </div>
                }
                {!this.state.startBtnPressed &&

                <div>
                    <div className="container text-center">



                        <div className="input-group">

                            <span className="input-group-text" htmlFor="width-input" >Timeout</span>
                            
                            <input id="timeout-input" type="number" className="form-control main-input" placeholder={this.state.timeout} value={this.state.timeout} onChange={this.onTimeoutChange}></input>
                        </div>


                        <div className="input-group">
                            <span className="input-group-text" htmlFor="width-input" >Font size</span>

                            <input id="timeout-input" type="number" className="form-control main-input" placeholder={this.state.fontSize} value={this.state.fontSize} onChange={this.onFontSizeChange}></input>
                        </div>


                    </div>

                    <hr></hr>

                    <div className="row text-center">
                        <div className="col">

                            <h2>Generate random initial state</h2>
                            <div className="input-group">
                                <span className="input-group-text" htmlFor="width-input" >Width</span>

                                <input id="width-input" type="number" className="form-control main-input" placeholder={this.state.width} value={this.state.width} onChange={this.onWidthChange}></input>
                                
                            </div>

                            <div className="input-group">

                                <span className="input-group-text" htmlFor="width-input" >Height</span>
                                <input id="height-input" type="number" className="form-control main-input" placeholder={this.state.height} value={this.state.height} onChange={this.onHeightChange}></input>
                            </div>

                        </div>


                        <div className="col">
                            <h2>Load initial state from csv</h2>
                            <i>Not yet implemented :(</i>
                        </div>
                    </div>


                    <div className="input-group">
                        <button className="btn btn-lg input-group start-btn" onClick={this.startBtnOnClick}>Start</button>
                    </div>
                </div>
                }
               
            </div>
        );
    }
}

const domContainer = document.querySelector('#react-main-component');
ReactDOM.render(<App />, domContainer);
